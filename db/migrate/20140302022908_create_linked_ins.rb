class CreateLinkedIns < ActiveRecord::Migration
  def change
    create_table :linked_ins do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :headline
      t.string :industry

      t.timestamps
    end
  end
end
