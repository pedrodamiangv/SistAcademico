class Alumno < ActiveRecord::Base
  attr_accessible :user_attributes, :responsable, :telefono_responsable, :curso_id, :doc_cedula, :doc_cert_estudios, :doc_cert_nacimiento, :doc_foto, :user_id
  belongs_to :user, :autosave => true
  belongs_to :curso
  has_many :puntajes
  has_many :calificaciones
  accepts_nested_attributes_for :user
  delegate :created_at, :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id, to: :user, prefix: true
  delegate :curso, :turno, :nivel, :enfasis, to: :curso, prefix: true
  validates :curso_id, presence: true
  validates :responsable, presence: true, length: {minimum: 5, maximum: 50}, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :telefono_responsable, presence: true, length: {minimum: 5, maximum: 13}, :format => { :with => /^\(\d{3,4}\)\s\d{6}$/ }
  before_save { build_user unless user }

  def full_name
    user_nombre.capitalize + ' ' + user_apellido.capitalize
  end
end
