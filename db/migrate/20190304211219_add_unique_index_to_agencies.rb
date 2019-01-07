class AddUniqueIndexToAgencies < ActiveRecord::Migration[5.1]
  def change
    add_index :agencies, [:name, :address], unique: true
  end
end
