class AddTipoToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :tipo, :string
  end
end
