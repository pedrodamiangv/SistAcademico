class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :nombre, :limit => 100, :null => false
      t.string :direccion, :limit => 50, :null => false
      t.string :telefono, :limit => 13, :null => false
      t.string :ciudad, :limit => 30, :null => false
      t.string :departamento, :limit => 30, :null => false
      t.string :email, :limit => 40, :null => false
      t.string :logo, :null => false

      t.timestamps
    end
  end
end
