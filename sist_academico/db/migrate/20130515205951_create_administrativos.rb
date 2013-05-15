class CreateAdministrativos < ActiveRecord::Migration
  def change
    create_table :administrativos do |t|
      t.integer :user_id
      t.string :cargo, :limit => 30

      t.timestamps
    end
  end
end
