class Position < ActiveRecord::Base
  belongs_to :linked_in

  def self.create_positions(linkedin, auth)
    positions = auth.extra.raw_info.positions.values[1]
    positions.each do |position|
      start_date = Date.new(position.startDate.year, position.startDate.month)
      end_date = Date.new(position.endDate.year, position.endDate.month)
      linkedin.positions.create({
        title: position.title,
        summary: position.summary,
        start_date: start_date,
        end_date: end_date,
        is_current: position.isCurrent
        })
    end
  end
end
