class AddMateriaIdToMateriales < ActiveRecord::Migration
  def change
    add_column :materiales, :materia_id, :integer, :null => false
  end
end
