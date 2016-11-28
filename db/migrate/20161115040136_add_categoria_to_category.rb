class AddCategoriaToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :categoria, :string
  end
end
