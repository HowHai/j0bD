class Dribbble < ActiveRecord::Base
  belongs_to :employee

  # Create Dribbble and save employee's Dribbble data
  # TODO: Create dribbble account using correct relationship method (employee.create_dribbble)
  def self.create_account(dribbble_username)
    drib = HTTParty.get("http://api.dribbble.com/players/#{dribbble_username}")
    drib_info = {
      username:                 drib["username"],
      shots_count:              drib["shots_count"],
      likes_count:              drib["likes_count"],
      likes_received_count:     drib["likes_received_count"],
      rebounds_count:           drib["rebounds_count"],
      rebounds_received_count:  drib["rebounds_received_count"]
    }
    Dribbble.create(drib_info)
  end
end
