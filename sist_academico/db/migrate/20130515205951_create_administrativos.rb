class CreateAdministrativos < ActiveRecord::Migration
  def change
    create_table :administrativos do |t|
      t.integer :user_id, :null => false
      t.string :cargo, :limit => 30, :null => false

      t.timestamps
    end
  end
end
