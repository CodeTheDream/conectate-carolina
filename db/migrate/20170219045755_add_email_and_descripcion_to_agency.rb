class AddEmailAndDescripcionToAgency < ActiveRecord::Migration[5.0]
  def change
    add_column :agencies, :email, :string
    add_column :agencies, :descripcion, :string
  end
end
