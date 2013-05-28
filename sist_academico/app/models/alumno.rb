class Alumno < ActiveRecord::Base
  attr_accessible :user_attributes, :responsable, :telefono_responsable, :curso_id, :doc_cedula, :doc_cert_estudios, :doc_cert_nacimiento, :doc_foto, :user_id
  belongs_to :user, :autosave => true
  belongs_to :curso
  accepts_nested_attributes_for :user
  delegate :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id, to: :user, prefix: true
  validates :curso_id, presence: true
  validates :responsable, presence: true, length: {minimum: 5, maximum: 30}
  validates :telefono_responsable, presence: true, length: {minimum: 5, maximum: 15}
  before_save { build_user unless user }
end
