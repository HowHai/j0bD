class EmployersController < ApplicationController
  def create
    # Probably should delete all this
    # auth = env["omniauth.auth"]
    # @employer = Employer.connect_to_linkedin(auth)
    # if @employer.persisted?
    #   session[:employer_id] = @employer.id
    #   redirect_to @employer
    # else
    #   redirect_to root_path
    # end
  end

  def show
    # List all employees for now
    @employees = Employee.all
  end

  def destroy
    session[:employer_id] = nil
    redirect_to root_path
  end

  def favoritelist
  end


end
