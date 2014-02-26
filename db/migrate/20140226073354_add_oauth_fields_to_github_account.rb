class AddOauthFieldsToGithubAccount < ActiveRecord::Migration
  def change
    add_column :github_accounts, :provider, :string
    add_column :github_accounts, :uid, :string
    add_column :github_accounts, :username, :string
    add_column :github_accounts, :oauth_token, :string
  end
end
