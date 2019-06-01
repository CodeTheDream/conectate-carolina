class RenameColumnOnMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :type, :message_type
  end
end
