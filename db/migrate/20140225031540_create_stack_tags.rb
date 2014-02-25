class CreateStackTags < ActiveRecord::Migration
  def change
    create_table :stack_tags do |t|
      t.references :stack_overflow_account, index: true

      t.timestamps
    end
  end
end
