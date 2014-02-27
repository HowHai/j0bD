class AddUserInfoToStackOverflowAccount < ActiveRecord::Migration
  def change
    add_column :stack_overflow_accounts, :reputation, :integer
    add_column :stack_overflow_accounts, :age, :integer
    add_column :stack_overflow_accounts, :badge_counts, :integer
  end
end
