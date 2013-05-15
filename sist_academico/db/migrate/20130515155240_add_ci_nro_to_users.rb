class AddCiNroToUsers < ActiveRecord::Migration
  def change
    add_column :users, :CINro, :string
  end
end
