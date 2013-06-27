class AddTipoToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :tipo, :string, :limit => 10, :null => false
  end
end
