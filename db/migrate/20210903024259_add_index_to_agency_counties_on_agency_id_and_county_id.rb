class AddIndexToAgencyCountiesOnAgencyIdAndCountyId < ActiveRecord::Migration[6.1]
  def change
    add_index :agency_counties, [:agency_id, :county_id], unique: true
  end
end
