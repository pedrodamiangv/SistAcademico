class Calificacion < ActiveRecord::Base
  attr_accessible :alumno_id, :calificacion, :materia_id, :puntos_correctos, :total_puntos, :etapa
  belongs_to :materia
  belongs_to :alumno
  delegate :full_name, to: :alumno, prefix: true
  delegate :materia, to: :materia, prefix: true
  validates :etapa, presence: true, length: { maximum: 15, minimum:3 }, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :alumno_id, presence: true
  validates :materia_id, presence: true
  validates :total_puntos, presence: true
  validates :puntos_correctos, presence: true
  validates :calificacion, presence: true, :numericality => {  :greater_than => 0, :less_than_or_equal_to => 5, message: 'La escala debe ser del 1 al 5' }
end
