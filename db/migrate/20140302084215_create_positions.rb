class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.string :summary
      t.date :start_date
      t.date :end_date
      t.boolean :is_current
      t.references :linkedin, index: true

      t.timestamps
    end
  end
end
