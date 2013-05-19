class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :curso, :limit => 20, :null => false
      t.string :turno, :limit => 10, :null => false
      t.string :nivel, :limit => 40, :null => false
      t.string :enfasis, :limit => 50, :null => false

      t.timestamps
    end
  end
end
