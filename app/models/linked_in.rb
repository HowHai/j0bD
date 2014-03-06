class LinkedIn < ActiveRecord::Base
  has_many :positions
  has_many :educations
  belongs_to :employee
  belongs_to :employer

  # Connect employee to their linkedin account and create new LinkedIn
  def self.connect_to_linkedin(auth, employee)
    user = employee.linked_in
    if user
      return user
    else
      # Extract and combines languages into one string
      if auth.extra.raw_info.languages.values[1]
        languages = ""
        auth.extra.raw_info.languages.values[1].each do |language|
          languages += language.language.name + " "
        end
        languages = languages.split.join(', ')
      end

      # Extract and combines skills into one string.
      if auth.extra.raw_info.skills.values[1]
        skills = ""
        auth.extra.raw_info.skills.values[1].each do |skill|
          skills += skill.skill.name + " "
        end
        skills = skills.split.join(', ')
      end

      user = employee.create_linked_in(
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

  # Create Employer account and connect to LinkedIn. This might be too messy, find another solution later.
  def self.connect_employer(auth)
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

      employer.create_linked_in(
        provider: auth.provider,
        uid: auth.uid
        )
      return employer
    end
  end
end
