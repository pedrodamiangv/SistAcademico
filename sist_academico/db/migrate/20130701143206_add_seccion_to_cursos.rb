class AddSeccionToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :seccion, :string, :limit => 1, :null => false
  end
end
