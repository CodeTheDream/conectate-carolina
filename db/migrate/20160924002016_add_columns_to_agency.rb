class AddColumnsToAgency < ActiveRecord::Migration[5.0]
  def change
    add_column :agencies, :zip_code, :string
    add_column :agencies, :state, :string
  end
end
