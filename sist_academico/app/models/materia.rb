class Materia < ActiveRecord::Base
  attr_accessible :area, :curso_id, :docente_id, :materia
  belongs_to :curso
  belongs_to :docente
  has_many :planificaciones
  delegate :descripcion, :etapa, :fecha_entrega, :tarea, :total_puntos, to: :planificacion, prefix: true
  delegate :curso, :turno, :nivel, :enfasis, to: :curso, prefix: true
  validates :curso_id, presence: true
  validates :docente_id, presence: true
  validates :materia, presence: true, length: {minimum: 5, maximum: 30}
  validates :area, length: {minimum: 5, maximum: 30}
end
