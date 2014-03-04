class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :employee, index: true
      t.references :employer, index: true

      t.timestamps
    end
  end
end
