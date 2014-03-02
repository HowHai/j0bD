class LinkedIn < ActiveRecord::Base
  has_many :positions

  # Connect user to their linkedin account and create new LinkedIn
  def self.connect_to_linkedin(auth)
    user = self.where(provider: auth.provider, uid: auth.uid)[0]
    if user
      return user
    else
      user = self.create(
          first_name: auth.info.first_name,
          headline: auth.info.description,
          industry: auth.extra.raw_info.industry,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email
        )
    end
  end
end
