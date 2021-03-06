OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # Github
  provider :github, '5bc3f4b827fdc3094fe5', '97015c95bf9309499a984fced3cec140206178ad', scope: 'user, public_repo, repo'

  provider :linkedin, "754ewh1ftt3ajs", "q0ezwYKjBOdPPgAQ",
  {
    scope: "r_fullprofile r_emailaddress r_network r_contactinfo",
    fields:
    [
      'first-name', 'headline', 'industry', 'positions', 'specialties', 'email-address', 'interests', 'languages', 'certifications', 'educations',
      'skills', 'num-recommenders', 'recommendations-received', 'proposal-comments', 'associations', 'job-bookmarks', 'connections', 'location:(name)', 'summary', 'public-profile-url'
    ],
    client_options:
    {
      ssl:
      {
        ca_file: Rails.root.join("cacert.pem").to_s
      }
    }
  }
end
