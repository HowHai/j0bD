class LinkedIn < ActiveRecord::Base
  has_many :positions
  has_many :educations

  # Connect user to their linkedin account and create new LinkedIn
  def self.connect_to_linkedin(auth)
    user = self.where(provider: auth.provider, uid: auth.uid)[0]
    if user
      return user
    else
      # Extract and combines languages into one string
      languages = ""
      auth.extra.raw_info.languages.values[1].each do |language|
        languages += language.language.name + " "
      end
      languages = languages.split.join(', ')

      # Extract and combines skills into one string.
      skills = ""
      auth.extra.raw_info.skills.values[1].each do |skill|
        skills += skill.skill.name + " "
      end
      skills = skills.split.join(', ')

      user = self.create(
          first_name: auth.info.first_name,
          headline: auth.info.description,
          industry: auth.extra.raw_info.industry,
          location: auth.info.location.name,
          languages: languages,
          interests: auth.extra.raw_info.interests,
          skills: skills,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email
        )
    end
  end
end
