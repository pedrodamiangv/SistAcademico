class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :curso, :limit => 20
      t.string :turno, :limit => 10
      t.string :nivel, :limit => 40
      t.string :enfasis, :limit => 50

      t.timestamps
    end
  end
end
