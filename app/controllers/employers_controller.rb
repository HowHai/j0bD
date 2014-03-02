class EmployersController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    binding.pry
    @employer = Employer.connect_to_linkedin(auth)
    if @employer.persisted?
      session[:employer_id] = @employer.id
      redirect_to @employer
    else
      redirect_to "root_path"
    end
  end

  def show
  end

  def destroy
    session[:employer_id] = nil
    redirect_to root_path
  end
end
