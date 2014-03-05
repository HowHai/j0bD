class AddCompanyNameToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :company_name, :string
  end
end
