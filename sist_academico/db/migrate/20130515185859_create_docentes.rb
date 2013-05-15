class CreateDocentes < ActiveRecord::Migration
  def change
    create_table :docentes do |t|
      t.integer :user_id
      t.integer :matricula, :limit => 20
      t.string :titulo, :limit => 50

      t.timestamps
    end
  end
end
