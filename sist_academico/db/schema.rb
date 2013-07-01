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

ActiveRecord::Schema.define(:version => 20130701143206) do

  create_table "addresses", :force => true do |t|
    t.string   "direccion"
    t.string   "barrio"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tipo"
  end

  add_index "addresses", ["city_id"], :name => "addresses_city_id_fk"

  create_table "administrativos", :force => true do |t|
    t.integer  "user_id"
    t.string   "cargo",      :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "titulo",     :limit => 30
  end

  add_index "administrativos", ["user_id"], :name => "administrativos_user_id_fk"

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

  add_index "alumnos", ["curso_id"], :name => "alumnos_curso_id_fk"
  add_index "alumnos", ["user_id"], :name => "alumnos_user_id_fk"

  create_table "alumnos_cursos", :id => false, :force => true do |t|
    t.integer "alumno_id", :null => false
    t.integer "curso_id",  :null => false
  end

  add_index "alumnos_cursos", ["alumno_id"], :name => "alumnos_cursos_alumno_id_fk"
  add_index "alumnos_cursos", ["curso_id"], :name => "alumnos_cursos_curso_id_fk"

  create_table "calificaciones", :force => true do |t|
    t.integer  "alumno_id",                                      :null => false
    t.integer  "materia_id",                                     :null => false
    t.integer  "calificacion",                                   :null => false
    t.integer  "total_puntos",                                   :null => false
    t.decimal  "puntos_correctos", :precision => 8, :scale => 2, :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "etapa",                                          :null => false
  end

  add_index "calificaciones", ["alumno_id"], :name => "calificaciones_alumno_id_fk"
  add_index "calificaciones", ["materia_id"], :name => "calificaciones_materia_id_fk"

  create_table "cities", :force => true do |t|
    t.string   "city"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["country_id"], :name => "cities_country_id_fk"

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
    t.string   "tipo",       :limit => 10, :null => false
    t.string   "seccion",    :limit => 1,  :null => false
  end

  create_table "docentes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "matricula"
    t.string   "titulo",     :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "docentes", ["user_id"], :name => "docentes_user_id_fk"

  create_table "materiales", :force => true do |t|
    t.string   "file",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "materia_id", :null => false
  end

  add_index "materiales", ["materia_id"], :name => "materiales_materia_id_fk"

  create_table "materias", :force => true do |t|
    t.string   "materia",    :limit => 30, :null => false
    t.string   "area",       :limit => 30, :null => false
    t.integer  "curso_id",                 :null => false
    t.integer  "docente_id",               :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "materias", ["curso_id"], :name => "materias_curso_id_fk"
  add_index "materias", ["docente_id"], :name => "materias_docente_id_fk"

  create_table "noticias", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "noticia",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "noticias", ["user_id"], :name => "noticias_user_id_fk"

  create_table "planificaciones", :force => true do |t|
    t.integer  "materia_id",                   :null => false
    t.string   "tarea",         :limit => 30,  :null => false
    t.string   "descripcion",   :limit => 100
    t.string   "etapa",         :limit => 20,  :null => false
    t.date     "fecha_entrega",                :null => false
    t.integer  "total_puntos",                 :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "planificaciones", ["materia_id"], :name => "planificaciones_materia_id_fk"

  create_table "preferencias", :force => true do |t|
    t.string   "codigo"
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "preferencias", ["user_id"], :name => "preferencias_user_id_fk"

  create_table "puntajes", :force => true do |t|
    t.integer  "planificacion_id",                                              :null => false
    t.integer  "alumno_id",                                                     :null => false
    t.decimal  "puntaje",                         :precision => 8, :scale => 2
    t.string   "descripcion",      :limit => 100
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  add_index "puntajes", ["alumno_id"], :name => "puntajes_alumno_id_fk"
  add_index "puntajes", ["planificacion_id"], :name => "puntajes_planificacion_id_fk"

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

  add_index "users", ["address_id"], :name => "users_address_id_fk"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  add_foreign_key "addresses", "cities", :name => "addresses_city_id_fk"

  add_foreign_key "administrativos", "users", :name => "administrativos_user_id_fk"

  add_foreign_key "alumnos", "cursos", :name => "alumnos_curso_id_fk"
  add_foreign_key "alumnos", "users", :name => "alumnos_user_id_fk"

  add_foreign_key "alumnos_cursos", "alumnos", :name => "alumnos_cursos_alumno_id_fk"
  add_foreign_key "alumnos_cursos", "cursos", :name => "alumnos_cursos_curso_id_fk"

  add_foreign_key "calificaciones", "alumnos", :name => "calificaciones_alumno_id_fk"
  add_foreign_key "calificaciones", "materias", :name => "calificaciones_materia_id_fk"

  add_foreign_key "cities", "countries", :name => "cities_country_id_fk"

  add_foreign_key "docentes", "users", :name => "docentes_user_id_fk"

  add_foreign_key "materiales", "materias", :name => "materiales_materia_id_fk"

  add_foreign_key "materias", "cursos", :name => "materias_curso_id_fk"
  add_foreign_key "materias", "docentes", :name => "materias_docente_id_fk"

  add_foreign_key "noticias", "users", :name => "noticias_user_id_fk"

  add_foreign_key "planificaciones", "materias", :name => "planificaciones_materia_id_fk"

  add_foreign_key "preferencias", "users", :name => "preferencias_user_id_fk"

  add_foreign_key "puntajes", "alumnos", :name => "puntajes_alumno_id_fk"
  add_foreign_key "puntajes", "planificaciones", :name => "puntajes_planificacion_id_fk"

  add_foreign_key "users", "addresses", :name => "users_address_id_fk"

end
