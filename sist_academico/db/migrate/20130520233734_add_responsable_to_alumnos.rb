class AddResponsableToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :responsable, :string, :limit => 30, :null => false
  end
end
