class CreateDribbbles < ActiveRecord::Migration
  def change
    create_table :dribbbles do |t|
      t.references :employee, index: true
      t.string :username
      t.integer :shots_count
      t.integer :likes_count
      t.integer :likes_received_count
      t.integer :rebounds_count
      t.string :rebounds_received_count

      t.timestamps
    end
  end
end
