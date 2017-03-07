class AddWebsiteTypeToWebsites < ActiveRecord::Migration[5.0]
  def change
    add_reference :websites, :website_type, foreign_key: true
  end
end
