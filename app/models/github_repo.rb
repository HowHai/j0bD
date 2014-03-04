class GithubRepo < ActiveRecord::Base
  belongs_to :github_account # one to many

  # validates name
end
