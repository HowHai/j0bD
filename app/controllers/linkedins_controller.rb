class LinkedinsController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    binding.pry
    @linkedin = LinkedIn.connect_to_linkedin(auth)
    if @linkedin.persisted?
      redirect_to '/linkedins/show'
    end
  end

  def show
    @linkedin = LinkedIn.last
  end
end
