class CreatePlanificaciones < ActiveRecord::Migration
  def change
    create_table :planificaciones do |t|
      t.integer :materia_id, :null => false
      t.string :tarea, :limit => 30, :null => false
      t.string :descripcion, :limit => 100
      t.string :etapa, :limit => 20, :null => false
      t.integer :curso_id, :null => false
      t.date :fecha_entrega, :null => false
      t.integer :total_puntos, :null => false

      t.timestamps
    end
  end
end
