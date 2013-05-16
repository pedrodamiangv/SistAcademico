class AddIsAdministrativoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_administrativo, :boolean
  end
end
