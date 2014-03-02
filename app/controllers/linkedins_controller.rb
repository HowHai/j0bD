class LinkedinsController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    binding.pry
    @linkedin = LinkedIn.connect_to_linkedin(auth)
    if @linkedin.persisted?
      Position.create_positions(@linkedin, auth)
      Education.create_educations(@linkedin, auth)
      redirect_to '/linkedins/show'
    end
  end

  def show
    @linkedin = LinkedIn.last
  end
end
