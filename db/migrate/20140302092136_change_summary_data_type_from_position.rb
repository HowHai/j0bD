class ChangeSummaryDataTypeFromPosition < ActiveRecord::Migration
  def change
    change_table :positions do |t|
      t.change :summary, :text
    end
  end
end
