class Employer < ActiveRecord::Base

  # Connect employer to their LinkedIn account
  def self.connect_to_linkedin(auth)
    employer = Employer.where(provider: auth.provider, uid: auth.uid)[0]
    if employer
      return employer
    else
      employer = Employer.create(
          name: auth.info.first_name,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email
        )
    end
  end
end
