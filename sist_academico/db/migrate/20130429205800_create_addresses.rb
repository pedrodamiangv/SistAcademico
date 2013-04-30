class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :direccion
      t.string :barrio
      t.integer :city_id

      t.timestamps
    end
  end
end
