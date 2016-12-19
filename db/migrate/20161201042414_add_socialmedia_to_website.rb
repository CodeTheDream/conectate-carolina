class AddSocialmediaToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :socialmedia, :string
  end
end
