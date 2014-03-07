class Education < ActiveRecord::Base
  belongs_to :linked_in

  validates :degree, presence: true

  def self.create_educations(linkedin, auth)
    educations = auth.extra.raw_info.educations.values[1]
    educations.each do |education|
      # Had some issues with retrieving startDate and endDate from LinkedIn
      # start_date = Date.new(education.startDate.to_h['year'])
      # end_date = Date.new(education.endDate.to_h['year'])
      linkedin.educations.create({
        degree: education.degree,
        field_of_study: education.fieldOfStudy,
        school_name: education.schoolName
        # start_date: start_date,
        # end_date: end_date
        })
    end
  end
end
