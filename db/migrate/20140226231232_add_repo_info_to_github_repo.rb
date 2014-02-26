class AddRepoInfoToGithubRepo < ActiveRecord::Migration
  def change
    add_column :github_repos, :name, :string
    add_column :github_repos, :Ruby, :integer
    add_column :github_repos, :CSS, :integer
    add_column :github_repos, :JavaScript, :integer
    add_column :github_repos, :CoffeeScript, :integer
    add_column :github_repos, :PHP, :integer
    add_column :github_repos, :Java, :integer
    add_column :github_repos, :Python, :integer
    add_column :github_repos, :C, :integer
    add_column :github_repos, :Shell, :integer
    add_column :github_repos, :Perl, :integer
    add_column :github_repos, :VimL, :integer
    add_column :github_repos, :Scala, :integer
    add_column :github_repos, :Go, :integer
    add_column :github_repos, :Prolog, :integer
    add_column :github_repos, :Clojure, :integer
    add_column :github_repos, :Haskell, :integer
    add_column :github_repos, :Lua, :integer
  end
end
