class RemoveReferenceFromPosition < ActiveRecord::Migration
  def change
    remove_reference :positions, :linkedin, index: true
  end
end
