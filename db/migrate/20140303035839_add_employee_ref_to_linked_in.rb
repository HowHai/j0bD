class AddEmployeeRefToLinkedIn < ActiveRecord::Migration
  def change
    add_reference :linked_ins, :employee, index: true
  end
end
