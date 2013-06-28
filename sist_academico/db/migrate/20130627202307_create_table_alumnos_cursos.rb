class CreateTableAlumnosCursos < ActiveRecord::Migration
  def change
    create_table :alumnos_cursos, id: false do |t|
      t.integer :alumno_id, :null => false
      t.integer :curso_id, :null => false
    end

    add_foreign_key :alumnos_cursos, :alumnos
    add_foreign_key :alumnos_cursos, :cursos
  end
end
