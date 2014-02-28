OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # Github
  provider :github, '5bc3f4b827fdc3094fe5', '97015c95bf9309499a984fced3cec140206178ad', scope: 'user, public_repo, repo'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "consumer_key", "consumer_secret"
end
