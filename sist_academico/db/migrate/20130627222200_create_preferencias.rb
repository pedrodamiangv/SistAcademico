class CreatePreferencias < ActiveRecord::Migration
  def change
    create_table :preferencias do |t|
      t.string :codigo
      t.integer :user_id
      t.string :value

      t.timestamps
    end
    add_foreign_key :preferencias, :users
  end
end
