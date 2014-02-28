class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :company
      t.string :name
      t.string :provider
      t.string :uid
      t.string :email

      t.timestamps
    end
  end
end
