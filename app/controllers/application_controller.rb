class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= GithubAccount.find(session[:github_id]) if session[:github_id]
  end

  # Get all languages data in each repo of a github_user
  def repos_languages_data(git_user)
    allRepos = []
    github = Github.new oauth_token: current_user.oauth_token
    myRepos = github.repos.list user: git_user
    myRepos.each do |repo|
      repo_languages = github.repos.languages git_user, repo.name
      repoHash = repo_languages.to_hash
      repoHash["name"] = repo.name
      repoHash["created_at"] = repo.created_at
      repoHash["updated_at"] = repo.updated_at
      allRepos.push(repoHash.symbolize_keys!)
    end
    allRepos
  end
end
