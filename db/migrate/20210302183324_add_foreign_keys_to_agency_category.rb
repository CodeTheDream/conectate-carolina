class AddForeignKeysToAgencyCategory < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :agency_categories, :agencies
    add_foreign_key :agency_categories, :categories
  end
end
