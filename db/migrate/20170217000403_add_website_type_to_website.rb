class AddWebsiteTypeToWebsite < ActiveRecord::Migration[5.0]
  def change
    rename_column :websites, :socialmedia, :url
    remove_column :website_types, :url
  end
end
