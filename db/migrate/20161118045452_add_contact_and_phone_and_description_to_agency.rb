class AddContactAndPhoneAndDescriptionToAgency < ActiveRecord::Migration[5.0]
  def change
    add_column :agencies, :contact, :string
    add_column :agencies, :phone, :string
    add_column :agencies, :description, :string
  end
end
