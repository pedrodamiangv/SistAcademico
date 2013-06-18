class AddEtapaToCalificaciones < ActiveRecord::Migration
  def change
    add_column :calificaciones, :etapa, :string, :null => false
  end
end
