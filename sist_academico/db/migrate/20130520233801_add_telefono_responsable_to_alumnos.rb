class AddTelefonoResponsableToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :telefono_responsable, :string, :limit => 15, :null => false
  end
end
