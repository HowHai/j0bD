class AddLocationToLinkedIn < ActiveRecord::Migration
  def change
    add_column :linked_ins, :location, :string
  end
end
