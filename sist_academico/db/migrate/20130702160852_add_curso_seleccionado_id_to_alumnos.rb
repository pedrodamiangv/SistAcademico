class AddCursoSeleccionadoIdToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :curso_seleccionado_id, :integer
  end
end
