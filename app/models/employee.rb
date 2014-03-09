class Employee < ActiveRecord::Base
  has_one :primary_stats
  has_one :github_account
  has_one :dribbble
  has_one :stack_overflow_account
  has_one :linked_in
  has_many :favorites # Need this?
  has_many :favorite_employers, through: :favorites, source: :employer

  # Create github account
  def create_github(auth)
    self.create_github_account({
      provider: auth['provider'],
      uid: auth['uid'],
      username: auth.extra.raw_info.login,
      oauth_token: auth.credentials.token
      })
  end

  # Modify top skills using all datas
  def skills_stats_modifier
    # Modify stats using StackOverflow's top_tags_score
    top_stats = self.github_top_skills

    if self.stack_overflow_account.nil?
      top_tags_score = self.calculate_top_tags_score
      # Hard code for now... out of time.
      ruby_tags = ['ruby', 'ruby-on-rails']
      javascript_tags = ['jquery', 'angularjs', 'nodejs']
      css_tags = ['html', 'css3', 'layout', 'haml', 'markdown']

      top_tags_score.each do |tag|
        if ruby_tags.include?(tag[:tag_name])
          top_stats[:ruby] += tag[:score]
        elsif javascript_tags.include?(tag[:tag_name])
          top_stats[:javascript] += tag[:score]
        elsif css_tags.include?(tag[:tag_name])
          top_stats[:css] += tag[:score]
        end
      end
    end

    # Modify stats using Dribbble
    if self.dribbble.nil?
      top_stats[:css] += self.calculate_dribbble_boost
    end

    # Modify stats using LinkedIn
    # headline: boost overall by %
    # industry: boost overall by %?
    # language: boost overall by %?
    # skills:   boost by ?????
    # -break it down to skills found?????
    # education: boost overall by %?
    # positions: boost by ??????
    # -break it down to skills found?

    # Simple LinkedIn solution for now...
    if self.linked_in.nil?
      linked_in_boost = self.calculate_linkedin_boost
      top_stats.each do |key, value|
        top_stats[key] = (value * linked_in_boost).to_i
      end
    end

    # Create / update employee's primary stats after calculation
    if self.primary_stats.nil?
      self.create_primary_stats(top_stats)
    else
      self.primary_stats.update(top_stats)
    end
  end

  # Get top skills from Github's data
  def github_top_skills
    ruby = javascript = coffeescript = css = php = 0
    allRepos = self.github_account.github_repos
    allRepos.each do |repo|
      ruby += repo.Ruby.to_i if repo.Ruby
      javascript += repo.JavaScript.to_i if repo.JavaScript
      coffeescript += repo.CoffeeScript.to_i if repo.CoffeeScript
      css += repo.CSS.to_i if repo.CSS
      php += repo.PHP.to_i if repo.PHP
    end
    repos = {ruby: ruby, javascript: javascript, coffeescript: coffeescript, css: css, php: php}

    # Save top 4 skills
    count = 0
    sorted_repos = repos.values.sort
    while repos.length > 4
      remove_key = repos.key(sorted_repos[count])
      repos.delete(remove_key)
      count += 1
    end

    return repos
  end

  # Get all tags related to top Github skills
  def top_tags
    related_tags = []
    all_tags = stack_overflow_account.stack_tags
    all_repos = github_top_skills.keys.map(&:to_s)

    # Add tags that are similar to any matched tag in all_repos to all_repos
    all_repos.each do |repo|
      case repo
      when 'ruby'
        all_repos.push(['ruby-on-rails'])
      when 'javascript'
        all_repos.push(['jquery'])
      when 'css'
        all_repos.push(['html', 'css3', 'layout', 'haml', 'markdown'])
      end
      all_repos.flatten!
    end

    all_tags.each do |tag|
      if all_repos.include?(tag.top_tag_name)
        related_tags.push({
          tag_name: tag.top_tag_name,
          answer_count: tag.answer_count,
          answer_score: tag.answer_score,
          question_count: tag.question_count,
          question_score: tag.question_score
          })
      end
    end
    related_tags
  end

  # Calculate top_tags overall score, only answers for now.
  def calculate_top_tags_score
    tags_score = []

    # Reputation weight
    reputation = stack_overflow_account.reputation

    top_tags.each do |tag|

      # Answer_score / answer_count * 10%
      multiplier = (tag[:answer_score] / tag[:answer_count]) * 0.02

      # Answer_score * multiplier * answer_count * answer_score + reputation
      score = ((tag[:answer_score] * multiplier * tag[:answer_count]) * tag[:answer_score]).round + reputation
      tags_score.push({tag_name: tag[:tag_name], score: score})
    end
    # Hacky way to remove dupls... check out why later
    tags_score.uniq

  end

  # Calculate Dribbble overall boost to front end stats
  def calculate_dribbble_boost
    my_dribbble = self.dribbble
    shots_score = my_dribbble.shots_count * 50
    likes_score = (my_dribbble.likes_count * 0.25).to_i
    likes_received_score = my_dribbble.likes_received_count
    rebounds_score = my_dribbble.rebounds_count * 100
    rebounds_received_score = my_dribbble.rebounds_received_count.to_i * 100

    dribbble_boost = (shots_score + likes_score + likes_received_score + rebounds_score + rebounds_received_score) * 100
  end

  # Calculate LinkedIn overall boost
  def calculate_linkedin_boost
    # Set score/weight for headline
    headline_score = calculate_LI_headline

    # Set score/weight for relevant industry?
    industry_score = calculate_LI_industry

    # Set score/weight for # of spoken languages?
    language_score = calculate_LI_languages

    # Set score/weight for relevant skills in skills list?
    skills_score = calculate_LI_skills

    # Calculate all data points to get overall general info score

    # Set score/weight for education
    education_score = calculate_LI_education
    # calculate all data points to get overall education score

    # Set score/weight at time employed at position
    # Set score/weight for relevant skill(s) in position summary
    # Set score/weight for relevant title in position
    positions_score = calculate_LI_positions

    # Calculate all data points to get overall position score
    # Test hash to view datas for now... should return a % modifier
    all_scores = {headline_score: headline_score, industry_score: industry_score, language_score: language_score, skills_score: skills_score, education_score: education_score, positions_score: positions_score}

    total_percentage_boost = 0;
    all_scores.values.each do |score|
      total_percentage_boost += (score * 0.001)
    end
    total_percentage_boost
  end

  ########## LinkedIn Score System Methods #######
  # Takes a list of words and string, return matched counts
  def words_scanner(words, text)
    matched_words = []
    return matched_words.length if text.nil?

    words.each do |word|
      if text.downcase.include?(word)
        matched_words.push(word)
      end
    end
    matched_words.length
  end

  # LinkedIn score for headline or Position title
  def calculate_LI_headline
    headlines = ['web designer', 'web designer', 'developer', 'web developer', 'Front End developer', 'Back End Developer', 'web architect']

    seniority_boost = ['senior', 'lead', 'sr']

    headlines_score = words_scanner(headlines, linked_in.headline) * 100
    seniority_score = words_scanner(seniority_boost, linked_in.headline) * 300

    total_stats_boost = headlines_score + seniority_score
  end

  # LinkedIn score for industry
  def calculate_LI_industry
    industries = ['civil engineering', 'computer games', 'computer hardware', 'computer networking', 'computer software', 'design', 'fine art', 'graphic design', 'information technology and services', 'internet', 'machinery', 'media production', 'mechanical engineering']

    industry_score = words_scanner(industries, linked_in.industry) * 100
  end

  # LinkedIn score for spoken languages
  def calculate_LI_languages
    linked_in.languages.split(',').count * 30
  end

  # LinkedIn score for skills
  def calculate_LI_skills
    top_skills = github_top_skills.keys.map(&:to_s)
    words_scanner(top_skills, self.linked_in.skills) * 50
  end

  # LinkedIn score for educations
  def calculate_LI_education
    relevant_fields = ['computer science', 'digital communication', 'media multimedia', 'computer and information sciences', 'artifical intelligence', 'information technology', 'informatics', 'computer and information sciences', 'computer programming', 'data processing', 'information science', 'computer systems', 'computer graphics', 'engineering', 'computer software', 'software engineering', 'computer engineering', 'computer hardware']

    bachelor_degree = ['bachelor', 'ba']
    master_degree = ['master', 'ma']

    my_degree = linked_in.educations.map(&:degree).compact.join(' ')
    my_field = linked_in.educations.map(&:field_of_study).compact.join(' ')

    # Field of study score
    field_score = words_scanner(relevant_fields, my_field)

    # Degree score(s)
    ba_score = words_scanner(bachelor_degree, my_degree)
    ma_score = words_scanner(master_degree, my_degree)

    education_score = (ba_score * 100) + (ma_score * 500) + (field_score * 500)

    # TODO: Bachelor and BA are credited if both included in degree.
  end

  # LinkedIn score for work experience(positions)
  def calculate_LI_positions
    titles = ['web designer', 'web designer', 'developer', 'web developer', 'Front End developer', 'Back End Developer', 'web architect']
    seniority_boost = ['senior', 'lead', 'sr']
    companies = ['google', 'facebook', 'twitter', 'linkedin']
    relevant_skills = self.top_tags.map {|tag| tag[:tag_name]}

    titles_score = 0
    summary_score = 0
    experience_score = 0
    company_score = 0

    self.linked_in.positions.each do |position|
      # Calculate score for position's title
      title = words_scanner(titles, position.title) * 10
      seniority = words_scanner(seniority_boost, position.title) * 50
      titles_score += (title + seniority)

      # Calculate score for position's summary
      summary_score += words_scanner(relevant_skills, position.summary) * 10

      # Calculate score for position's experience
      days_at_job = (position.end_date - position.start_date).to_i
      if title > 0
        experience_score += days_at_job * 1
      elsif title > 0 && seniority > 0
        experience_score += days_at_job * 2
      else
        experience_score += days_at_job * 0.25
      end

      # Calculate score for position's company
      company_score += words_scanner(companies, position.company_name) * 500
    end

    total_positions_score = titles_score + summary_score + experience_score.to_i + company_score
  end

  # Total days at job as a developer
  def developer_experience
    titles = ['web designer', 'web designer', 'developer', 'web developer', 'Front End developer', 'Back End Developer', 'web architect']
    seniority_boost = ['senior', 'lead', 'sr']

    total_experience_score = 0

    self.linked_in.positions.each do |position|
      title = words_scanner(titles, position.title) * 10
      seniority = words_scanner(seniority_boost, position.title) * 50
      titles_score = (title + seniority)
      experience_score = 0

      # Calculate score for position's experience
      days_at_job = (position.end_date - position.start_date).to_i
      if title > 0
        experience_score += days_at_job * 1
      elsif title > 0 && seniority > 0
        experience_score += days_at_job * 2
      else
        experience_score += days_at_job * 0
      end

      total_experience_score += titles_score + experience_score
    end
    total_experience_score
  end
end
