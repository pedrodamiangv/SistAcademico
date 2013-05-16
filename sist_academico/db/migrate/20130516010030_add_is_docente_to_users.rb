class AddIsDocenteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_docente, :boolean
  end
end
