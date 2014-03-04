class Employee < ActiveRecord::Base
  has_one :github_account
  has_one :dribbble
  has_one :stack_overflow_account
  has_one :linked_in
  has_many :favorites
  has_many :favorite_employers, through: :favorites, source: :employer

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
end
