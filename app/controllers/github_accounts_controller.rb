class GithubAccountsController < ApplicationController
  def create
    # Assign env["omniauth.auth"] from request to auth
    auth = request.env["omniauth.auth"]

    # Check for existing account, else create a new one
    github_user = GithubAccount.find_by_provider_and_uid(auth[:provider], auth[:uid]) || GithubAccount.create_with_omniauth(auth)
    # Hacky way to update username

    github_user.update(username: auth.extra.raw_info.login)

    @employee = Employee.find_by(git_account: github_user.username)

    # Create new employee if user sign up with Github
    if @employee.nil?
      # Just connects employee and github account for now
      @employee = Employee.new(git_account: github_user.username)
      @employee.save # Add restrictions here later?

      # Connect GithubAccount to Employee
      github_user.update(employee_id: @employee.id)

      session[:github_id] = github_user.id

      # Create repositories
      allRepos = repos_languages_data(github_user.username)
      allRepos.each do |repo|
        merged_repo = repo.merge(github_account_id: github_user.id)
        GithubRepo.create(merged_repo)
      end
    else
      # Store session when @employee is found
      session[:github_id] = github_user.id
    end

    redirect_to root_path
  end

  def destroy
    session[:github_id] = nil
    redirect_to root_path
  end
end
