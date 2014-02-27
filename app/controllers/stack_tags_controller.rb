class StackTagsController < ApplicationController
  def create
    # Check to see if user already have an account attached to their profile
    stack_user = StackOverflowAccount.find_by(id: params[:stackoverflow_id])

    # Create StackOverflowAccount and connect it to their profile
    if stack_user.nil?
      #TODO Might want to strong params this later
      stack_info = get_stack_user_info(params[:stackoverflow_id])
      stack_user = StackOverflowAccount.new(stack_info)
    end

    if stack_user.save
      # Create tags for stack_user
      stack_user.create_tags
      # Connect new stack account to current employee
      # current_employee.update(stack_overflow_account: stack_user.id)

      # Connect current employee to new stack account
      stack_user.update(employee_id: current_employee.id)

      redirect_to employee_path(current_employee.id)
    end
  end
end
