class CreateStackOverflowAccounts < ActiveRecord::Migration
  def change
    create_table :stack_overflow_accounts do |t|
      t.references :employee, index: true

      t.timestamps
    end
  end
end
