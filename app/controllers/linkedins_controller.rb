class LinkedinsController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    binding.pry

    # Link LinkedIn account to current_employee
    if current_employee
      @linkedin = LinkedIn.connect_to_linkedin(auth, current_employee)
      if @linkedin.persisted?
        Position.create_positions(@linkedin, auth)
        Education.create_educations(@linkedin, auth)
        redirect_to employee_path(current_employee.id)
      end
    else
      # Connect / Sign up employer
      @employer = LinkedIn.connect_employer(auth)
      if @employer.persisted?
        session[:employer_id] = @employer.id
        redirect_to @employer
      else
        # Do something to handle a failed log in / sign up for employer
      end
    end
  end

  def show
    @linkedin = LinkedIn.last
  end
end
