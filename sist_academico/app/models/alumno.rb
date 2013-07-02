class Alumno < ActiveRecord::Base
  attr_accessible :curso_seleccionado_id, :user_attributes, :responsable, :telefono_responsable, :curso_id, :doc_cedula, :doc_cert_estudios, :doc_cert_nacimiento, :doc_foto, :user_id
  belongs_to :user, :autosave => true
  belongs_to :curso
  has_and_belongs_to_many :cursos, join_table: :alumnos_cursos, :autosave => true
  has_many :puntajes
  has_many :calificaciones
  accepts_nested_attributes_for :user
  delegate :created_at, :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id, to: :user, prefix: true
  delegate :curso_grado, :curso, :turno, :nivel, :enfasis, to: :curso, prefix: true
  #validates :user_username, uniqueness: { message: "Este nombre de usuario ya existe. " }
  validates :responsable, presence: true, length: {minimum: 5, maximum: 50}, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :telefono_responsable, presence: true, length: {minimum: 5, maximum: 13}, :format => { :with => /^\(\d{3,4}\)\s\d{6}$/ }
  before_save { build_user unless user }

  def full_name
    user_nombre.capitalize + ' ' + user_apellido.capitalize
  end

  def responsable_full
    if self.responsable && self.telefono_responsable
      self.responsable + ' | ' + self.telefono_responsable
    else
      ""
    end
  end

  def curso_actual
    self.cursos.last
  end

  def curso_seleccionado
    curso_elegido = self.curso_actual
    self.cursos.each do |curso|
      if curso.id == self.curso_seleccionado_id
        curso_elegido = curso
      end
    end
    curso_elegido
  end

end
