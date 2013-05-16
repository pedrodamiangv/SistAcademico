class AddIsAlumnoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_alumno, :boolean
  end
end
