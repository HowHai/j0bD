class GithubAccount < ActiveRecord::Base
  belongs_to :employee
  has_many :github_repos # one to many

  validates :provider, :oauth_token, presence: true
  validates_inclusion_of :provider, in:['github']

  # Has not been tested...
  # Do I need this anymore?
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth.extra.raw_info.login
      user.oauth_token = auth.credentials.token
    end
  end
end
