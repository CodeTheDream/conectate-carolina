class AddMobilePhoneToAgencies < ActiveRecord::Migration[6.0]
  def change
    add_column :agencies, :mobile_phone, :string
  end
end
