class AddSelectedLangToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :selected_lang, :string
  end
end
