class AddUniqueIndexToAgencies < ActiveRecord::Migration[5.1]
  def change
    add_index :agencies, [:name, :address, :city, :state, :zipcode], unique: true, name: "unique_index_on_agencies"
  end
end
