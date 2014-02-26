class GithubReposController < ApplicationController

  def index
    @github_repos = GithubRepo.all
  end

end
