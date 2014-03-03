class LinkedinsController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    # binding.pry

    # Link LinkedIn account to current_employee
    if current_employee
      @linkedin = LinkedIn.connect_to_linkedin(auth, current_employee)
      if @linkedin.persisted?
        Position.create_positions(@linkedin, auth)
        Education.create_educations(@linkedin, auth)
        redirect_to employee_path(current_employee.id)
      end
    end
  end

  def show
    @linkedin = LinkedIn.last
  end
end
