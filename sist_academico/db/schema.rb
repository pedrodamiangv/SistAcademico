# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130520233801) do

  create_table "addresses", :force => true do |t|
    t.string   "direccion"
    t.string   "barrio"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "administrativos", :force => true do |t|
    t.integer  "user_id"
    t.string   "cargo",      :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "titulo",     :limit => 30
  end

  create_table "alumnos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "curso_id"
    t.boolean  "doc_cedula"
    t.boolean  "doc_cert_estudios"
    t.boolean  "doc_foto"
    t.boolean  "doc_cert_nacimiento"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "responsable",          :limit => 30, :null => false
    t.string   "telefono_responsable", :limit => 15, :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "city"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "pais"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cursos", :force => true do |t|
    t.string   "curso",      :limit => 20
    t.string   "turno",      :limit => 10
    t.string   "nivel",      :limit => 40
    t.string   "enfasis",    :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "docentes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "matricula"
    t.string   "titulo",     :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "materias", :force => true do |t|
    t.string   "materia",    :limit => 30, :null => false
    t.string   "area",       :limit => 30, :null => false
    t.integer  "curso_id",                 :null => false
    t.integer  "docente_id",               :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "sexo"
    t.string   "telefono"
    t.string   "fecha_nacimiento"
    t.string   "lugar_nacimiento"
    t.integer  "edad"
    t.string   "username",                     :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "address_id"
    t.string   "CINro"
    t.boolean  "is_alumno"
    t.boolean  "is_docente"
    t.boolean  "is_administrativo"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
