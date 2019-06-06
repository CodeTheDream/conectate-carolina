class AddPostedToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :posted, :boolean, default: false
  end
end
