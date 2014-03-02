class AddLiReferenceToPosition < ActiveRecord::Migration
  def change
    add_reference :positions, :linked_in, index: true
  end
end
