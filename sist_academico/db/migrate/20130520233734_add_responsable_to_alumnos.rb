class AddResponsableToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :responsable, :string
  end
end
