class CreateSocialMedia < ActiveRecord::Migration[5.0]
	belongs_to :agency
	
  def change
    create_table :social_media do |t|
      t.references :agency_id, foreign_key: true

      t.timestamps
    end
  end
end
