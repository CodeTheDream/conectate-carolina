class AddTituloAndCuerpoToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :titulo, :string
    add_column :messages, :cuerpo, :text
  end
end
