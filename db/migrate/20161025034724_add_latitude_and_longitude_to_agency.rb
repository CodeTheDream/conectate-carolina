class AddLatitudeAndLongitudeToAgency < ActiveRecord::Migration[5.0]
  def change
    add_column :agencies, :latitude, :float
    add_column :agencies, :longitude, :float
  end
end
