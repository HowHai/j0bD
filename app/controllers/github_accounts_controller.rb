class GithubAccountsController < ApplicationController

  def create
    # Assigns env["omniauth.auth"] from request to auth
    auth = request.env["omniauth.auth"]

    github_user = GithubAccount.find_by_provider_and_uid(auth[:provider], auth[:uid])

    if github_user.nil?
      @employee = Employee.create
      github_user = @employee.create_github(auth)

      session[:user_id] = @employee.id
      # Create repositories
      allRepos = repos_languages_data(github_user.username)
      allRepos.each do |repo|
        merged_repo = repo.merge(github_account_id: github_user.id)
        GithubRepo.create(merged_repo)
      end
      # Update employee's stats
      @employee.skills_stats_modifier
    else
      @employee = github_user.employee
      session[:user_id] = @employee.id
    end

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
