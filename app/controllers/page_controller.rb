class PageController < ApplicationController
  def landing_page
    # If logged in, redirect user to their profile
    if current_user
      redirect_to employee_path(current_user.employee_id)
    end
  end
end
