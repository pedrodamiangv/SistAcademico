class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :direccion, :limit => 30, :null => false
      t.string :barrio, :limit => 30, :null => false
      t.integer :city_id, :null => false

      t.timestamps
    end
  end
end
