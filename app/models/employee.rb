class Employee < ActiveRecord::Base
  has_one :github_account
  has_one :dribbble
  has_one :stack_overflow_account
  has_one :linked_in
  has_many :favorites
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
      multiplier = (tag[:answer_score] / tag[:answer_count]) * 0.01

      # Answer_score * multiplier * answer_count * answer_score + reputation
      score = ((tag[:answer_score] * multiplier * tag[:answer_count]) * tag[:answer_score]).round + reputation
      tags_score.push({tag_name: tag[:tag_name], score: score})
    end
    tags_score
  end

  # Calculate Dribbble overall boost to front end stats
  def calculate_dribbble_boost
    #
  end

  # Calculate LinkedIn overall boost
  def calculate_linkedin_boost
    # Set score/weight for relevant headline?
    headline_score = calculate_LI_headline(linked_in.headline)
    # Set score/weight for relevant industry?
    # Set score/weight for relevant interests?
    # Set score/weight for # of spoken languages?
    # Set score/weight for relevant skills in skills list?
    # Calculate all data points to get overall general info score

    # Set score/weight for education
    # calculate all data points to get overall education score

    # Set score/weight at time employed at position
    # Set score/weight for relevant skill(s) in position summary
    # Set score/weight for relevant title in position
    # Calculate all data points to get overall position score
  end

  private

  # Takes a list of words and string, return matched counts
  def words_scanner(words, text)
    text = text.downcase
    matched_words = []

    words.each do |word|
      if text.include?(word)
        matched_words.push(word)
      end
    end
    matched_words.length
  end

  # LinkedIn score for headline or Position title
  def calculate_LI_headline(employee_headline)
    headlines = ['web designer', 'web designer', 'developer', 'web developer', 'Front End developer', 'Back End Developer', 'web architect']

    seniority_boost = ['senior', 'lead', 'sr']

    headlines_score = words_scanner(headlines, employee_headline) * 10
    seniority_score = words_scanner(seniority_boost, employee_headline) * 50

    total_stats_boost = headlines_score + seniority_score
  end
end
