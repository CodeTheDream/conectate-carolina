class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.references :agency, foreign_key: true

      t.timestamps
    end
  end
end
