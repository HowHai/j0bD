class DribbblesController < ApplicationController
  def create
    if current_employee
      @dribbble = Dribbble.create_account(params[:dribbble_username])
      @dribbble.update(employee_id: current_employee.id)
      redirect_to employee_path(current_employee.id)
    end
  end
end
