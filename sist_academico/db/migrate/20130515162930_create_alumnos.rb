class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.integer :user_id
      t.integer :curso_id
      t.boolean :doc_cedula
      t.boolean :doc_cert_estudios
      t.boolean :doc_foto
      t.boolean :doc_cert_nacimiento

      t.timestamps
    end
  end
end
