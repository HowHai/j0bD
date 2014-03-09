class DribbblesController < ApplicationController
  def create
    if current_employee
      @dribbble = Dribbble.create_account(params[:dribbble_username])
      @dribbble.update(employee_id: current_employee.id)

      current_employee.skills_stats_modifier
      redirect_to employee_path(current_employee.id)
    end
  end
end
