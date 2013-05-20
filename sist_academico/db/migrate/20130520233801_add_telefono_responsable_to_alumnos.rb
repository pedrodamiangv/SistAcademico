class AddTelefonoResponsableToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :telefono_responsable, :string
  end
end
