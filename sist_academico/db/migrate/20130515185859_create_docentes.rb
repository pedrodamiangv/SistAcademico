class CreateDocentes < ActiveRecord::Migration
  def change
    create_table :docentes do |t|
      t.integer :user_id, :null => false
      t.integer :matricula, :limit => 20, :null => false
      t.string :titulo, :limit => 50, :null => false

      t.timestamps
    end
  end
end
