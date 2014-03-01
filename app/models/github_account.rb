class GithubAccount < ActiveRecord::Base
  belongs_to :employee
  has_many :github_repos

  validates :employee_id, :provider, :uid, :oauth_token, presence: true
  validates_inclusion_of :provider, in:['github']

  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth.info.name # This does not save... weird
      user.oauth_token = auth.credentials.token
    end
  end
end
