class GithubRepo < ActiveRecord::Base
  belongs_to :github_account

  # validates name
end
