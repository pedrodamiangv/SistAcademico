class CreateCalificaciones < ActiveRecord::Migration
  def change
    create_table :calificaciones do |t|
      t.integer :alumno_id, :null => false
      t.integer :materia_id, :null => false
      t.integer :calificacion, :null => false
      t.integer :total_puntos, :null => false
      t.decimal :puntos_correctos, :precision => 8, :scale => 2, :null => false

      t.timestamps
    end
  end
end
