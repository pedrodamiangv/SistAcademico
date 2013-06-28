class CreateNoticias < ActiveRecord::Migration
  def change
    create_table :noticias do |t|
      t.integer :user_id, :null => false
      t.text :noticia, :null => false

      t.timestamps
    end

    add_foreign_key :noticias, :users
  end
end
