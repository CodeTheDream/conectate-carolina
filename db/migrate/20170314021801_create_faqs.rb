class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
      t.string :question
      t.text :answer
      t.string :pregunta
      t.text :respuesta

      t.timestamps
    end
  end
end
