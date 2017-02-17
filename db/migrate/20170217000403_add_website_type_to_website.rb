class AddWebsiteTypeToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_reference :websites, :website_type, foreign_key: true
    rename_column :websites, :socialmedia, :url
    remove_column :website_types, :url
  end
end
