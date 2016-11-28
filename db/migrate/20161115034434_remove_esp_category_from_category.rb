class RemoveEspCategoryFromCategory < ActiveRecord::Migration[5.0]
  def change
  end

  def up
  	remove_column :esp_category
  end
end
