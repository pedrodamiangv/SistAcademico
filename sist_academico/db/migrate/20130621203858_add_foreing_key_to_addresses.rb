class AddForeingKeyToAddresses < ActiveRecord::Migration
  def change
  	add_foreign_key :addresses, :cities
  end
end
