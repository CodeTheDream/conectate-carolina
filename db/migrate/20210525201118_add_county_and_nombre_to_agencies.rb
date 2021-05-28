class AddCountyAndNombreToAgencies < ActiveRecord::Migration[6.1]
  def change
    add_column :agencies, :county, :string
    add_column :agencies, :nombre, :string
  end
end
