class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def update
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new
    redirect_to "/"
  end

  def show
      @employee = Employee.find(params[:id])
  end
end
