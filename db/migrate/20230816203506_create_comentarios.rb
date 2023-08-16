class CreateComentarios < ActiveRecord::Migration[7.0]
  def change
    create_table :comentarios do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :publicacion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
