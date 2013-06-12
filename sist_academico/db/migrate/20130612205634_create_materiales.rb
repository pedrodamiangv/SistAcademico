class CreateMateriales < ActiveRecord::Migration
  def change
    create_table :materiales do |t|
      t.string :file, :null => false

      t.timestamps
    end
  end
end
