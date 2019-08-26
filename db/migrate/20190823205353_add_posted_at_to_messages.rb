class AddPostedAtToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :posted_at, :datetime
  end
end
