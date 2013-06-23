class AddForeignKeyToTables < ActiveRecord::Migration
  def change
  	add_foreign_key :users, :addresses
  	add_foreign_key :administrativos, :users
  	add_foreign_key :alumnos, :users
  	add_foreign_key :alumnos, :cursos
  	add_foreign_key :docentes, :users
  	add_foreign_key :materias, :docentes
  	add_foreign_key :materias, :cursos
  	add_foreign_key :planificaciones, :materias
  	add_foreign_key :materiales, :materias
  	add_foreign_key :puntajes, :alumnos
  	add_foreign_key :puntajes, :planificaciones
  	add_foreign_key :calificaciones, :alumnos
  	add_foreign_key :calificaciones, :materias
  end
end
