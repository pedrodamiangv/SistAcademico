class CreatePuntajes < ActiveRecord::Migration
  def change
    create_table :puntajes do |t|
      t.integer :planificacion_id, :null => false
      t.integer :alumno_id, :null => false
      t.decimal :puntaje, :precision => 8, :scale => 2
      t.string :descripcion, :limit => 100

      t.timestamps
    end
  end
end
