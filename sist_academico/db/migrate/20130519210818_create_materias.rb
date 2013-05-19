class CreateMaterias < ActiveRecord::Migration
  def change
    create_table :materias do |t|
      t.string :materia, :limit => 30, :null => false
      t.string :area, :limit => 30, :null => false
      t.integer :curso_id, :null => false
      t.integer :docente_id, :null => false

      t.timestamps
    end
  end
end
