class GithubReposController < ApplicationController

  def create
    # Create an employee and repos when user sign up / log in with Github
    # @employee = Employee.find_by(git_account:)

  end




  def index
    @github_repos = GithubRepo.all
  end

  def show
    @github_repo = GithubRepo.find(params[:id])
  end

end
