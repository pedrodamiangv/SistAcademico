class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nombre,           :default => nil
      t.string :apellido,         :default => nil
      t.string :sexo,             :default => nil
      t.string :telefono,         :default => nil
      t.string :fecha_nacimiento, :default => nil
      t.string :lugar_nacimiento, :default => nil
      t.string :direccion,        :default => nil
      t.integer :edad,            :default => nil
      t.string :username,         :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end