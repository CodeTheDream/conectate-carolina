class CreateAgencies < ActiveRecord::Migration[5.0]
  has_many :social_media
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.timestamps
    end
  end
end
