class CreateDeviceMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :device_messages do |t|
      t.references :device, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true
      t.string :ticket_id
      t.string :status
      t.json :error_messages

      t.timestamps
    end
  end
end
