class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :linked_in, index: true
      t.string :degree
      t.date :end_date
      t.date :start_date
      t.string :field_of_study
      t.string :school_name

      t.timestamps
    end
  end
end
