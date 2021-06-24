class CreateAgencyUpdateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :agency_update_requests do |t|
      t.string :name
      t.string :nombre
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :county
      t.float :latitude
      t.float :longitude
      t.string :contact
      t.string :phone
      t.string :description
      t.string :email
      t.string :descripcion
      t.string :mobile_phone
      t.string :status, default: 'submitted'

      t.timestamps
    end
  end
end
