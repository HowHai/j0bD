class PageController < ApplicationController
  def landing_page
    # If logged in, redirect user to their profile
    if current_employee
      redirect_to employee_path(current_employee.id)
    end
  end
end
