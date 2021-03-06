class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_employee, :current_employer


  def current_employer
    @current_employer ||= Employer.find(session[:employer_id]) if session[:employer_id]
  end

  # Hacky way... change this later
  def current_employee
    @current_employee ||= Employee.find_by(id: session[:user_id])
  end

  # Get all languages data in each repo of a github_user
  # Should refractor this and put in github account model
  def repos_languages_data(git_user)
    allRepos = []
    github = Github.new oauth_token: current_employee.github_account.oauth_token
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

  # Get StackOverflow user's basic info
  def get_stack_user_info(user_id)
    user_info = HTTParty.get("https://api.stackexchange.com/2.2/users/" + user_id + "?order=desc&sort=reputation&site=stackoverflow&filter=!406FePY_tk75WKBzx&key=d9Fe13Jxvcb)WMzdPi8t7A((")

    user_info = user_info["items"][0]
    total_badges = user_info["badge_counts"].values.sum
    stack_info = {id: user_id, reputation: user_info["reputation"], age: user_info["age"].to_i, badge_counts: total_badges}
    stack_info
  end
end
