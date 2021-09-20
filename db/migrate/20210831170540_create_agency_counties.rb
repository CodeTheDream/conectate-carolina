class CreateAgencyCounties < ActiveRecord::Migration[6.1]
  def change
    create_table :agency_counties do |t|
      t.references :agency, null: false, foreign_key: true
      t.references :county, null: false, foreign_key: true

      t.timestamps
    end
  end
end
