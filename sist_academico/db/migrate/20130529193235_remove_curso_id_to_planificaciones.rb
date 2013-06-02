class RemoveCursoIdToPlanificaciones < ActiveRecord::Migration
  def up
    remove_column :planificaciones, :curso_id
  end

  def down
    add_column :planificaciones, :curso_id, :integer
  end
end
