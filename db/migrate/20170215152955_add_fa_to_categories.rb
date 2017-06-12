class AddFaToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :fa_name, :string
  end
end
