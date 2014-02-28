class EmployersController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    @employer = Employer.connect_to_linkedin(auth)
    if @employer.persisted?
      session[:employer_id] = @employer.id
      redirect_to root_path
    else
      redirect_to "root_path"
    end
  end

  def destroy
    session[:employer_id] = nil
    redirect_to root_path
  end
end
