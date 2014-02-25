class CreateGithubAccounts < ActiveRecord::Migration
  def change
    create_table :github_accounts do |t|
      t.references :employee, index: true

      t.timestamps
    end
  end
end
