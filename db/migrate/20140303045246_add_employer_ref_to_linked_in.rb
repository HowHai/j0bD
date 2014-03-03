class AddEmployerRefToLinkedIn < ActiveRecord::Migration
  def change
    add_reference :linked_ins, :employer, index: true
  end
end
