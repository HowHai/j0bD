class Position < ActiveRecord::Base
  belongs_to :linked_in

  def self.create_positions(linkedin, auth)
    positions = auth.extra.raw_info.positions.values[1]
    positions.each do |position|
      linkedin.positions.create({
        title: position.title,
        summary: position.summary,
        # start_date:
        # end_date:
        is_current: position.isCurrent
        })
    end
  end
end
