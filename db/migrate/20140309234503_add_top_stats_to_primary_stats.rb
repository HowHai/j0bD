class AddTopStatsToPrimaryStats < ActiveRecord::Migration
  def change
    add_column :primary_stats, :first_stats, :integer
  end
end
