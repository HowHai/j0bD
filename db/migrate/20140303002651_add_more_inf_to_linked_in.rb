class AddMoreInfToLinkedIn < ActiveRecord::Migration
  def change
    add_column :linked_ins, :summary, :text
    add_column :linked_ins, :interests, :text
    add_column :linked_ins, :languages, :string
    add_column :linked_ins, :skills, :text
  end
end
