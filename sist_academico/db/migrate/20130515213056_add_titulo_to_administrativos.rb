class AddTituloToAdministrativos < ActiveRecord::Migration
  def change
    add_column :administrativos, :titulo, :string, :limit => 30
  end
end
