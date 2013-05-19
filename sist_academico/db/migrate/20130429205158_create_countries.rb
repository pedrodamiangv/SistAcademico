class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :pais, :limit => 30, :null => false

      t.timestamps
    end
  end
end
