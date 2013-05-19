class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :city, :limit => 30, :null => false
      t.integer :country_id, :null => false

      t.timestamps
    end
  end
end
