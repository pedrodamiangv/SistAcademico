class Alumno < ActiveRecord::Base
  attr_accessible :responsable, :telefono_responsable, :curso_id, :doc_cedula, :doc_cert_estudios, :doc_cert_nacimiento, :doc_foto, :user_id
  belongs_to :user
  belongs_to :curso
  validates :curso_id, presence: true
  validates :user_id, presence: true
  validates :responsable, presence: true, length: {minimum: 5, maximum: 30}
  validates :telefono_responsable, presence: true, length: {minimum: 5, maximum: 15}
end
