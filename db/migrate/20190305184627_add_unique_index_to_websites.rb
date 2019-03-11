class AddUniqueIndexToWebsites < ActiveRecord::Migration[5.1]
  def change
    add_index :websites, [:agency_id, :website_type_id, :url], unique: true,
      name: "index_websites_on_agencyId_websiteTypeId_and_url"
  end
end
