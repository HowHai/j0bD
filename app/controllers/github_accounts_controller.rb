class GithubAccountsController < ApplicationController
  def create
    # Assign env["omniauth.auth"] from request to auth
    auth = request.env["omniauth.auth"]

    # Check for existing account, else create a new one
    github_user = GithubAccount.find_by_provider_and_uid(auth[:provider], auth[:uid]) || GithubAccount.create_with_omniauth(auth)
    # Hacky way to update username
    github_user.update(username: auth.info.name)
    session[:github_id] = github_user.id
    redirect_to root_path
  end

  def destroy
    session[:github_id] = nil
    redirect_to root_path
  end
end
