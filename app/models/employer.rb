class Employer < ActiveRecord::Base
  has_one :linked_in
  has_many :favorites
  has_many :favorite_employees, through: :favorites, source: :employee

  validates :name, presence: true

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

  def add_favorite(employee)
    self.favorites.create(employee_id: employee.id)
  end
end
