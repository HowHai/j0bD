class AddGitAccountAndStackAccountToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :git_account, :string
    add_column :employees, :stack_overflow_account, :integer
  end
end
