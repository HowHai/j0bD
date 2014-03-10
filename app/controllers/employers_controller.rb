class EmployersController < ApplicationController

  def index
    @employee = Employee.last
    @employees = Employee.all
    @top_stats = @employee.get_top_stats
  end

  def create
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
