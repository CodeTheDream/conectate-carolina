class AddIconAndUrlToWebsiteType < ActiveRecord::Migration[5.0]
  def change
    add_column :website_types, :icon, :string
    add_column :website_types, :url, :string
  end
end
