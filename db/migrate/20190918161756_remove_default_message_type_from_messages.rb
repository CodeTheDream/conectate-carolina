class RemoveDefaultMessageTypeFromMessages < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:messages, :message_type, nil)
  end
end
