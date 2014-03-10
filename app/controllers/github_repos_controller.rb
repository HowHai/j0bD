class GithubReposController < ApplicationController

  def create
  end




  def index
    @github_repos = GithubRepo.all
  end

  def show
    @github_repo = GithubRepo.find(params[:id])
  end

end
