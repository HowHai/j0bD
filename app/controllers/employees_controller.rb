class EmployeesController < ApplicationController

  def update
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new
    redirect_to "/"
  end
end
