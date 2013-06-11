class Planificacion < ActiveRecord::Base
  attr_accessible :descripcion, :etapa, :fecha_entrega, :materia_id, :tarea, :total_puntos
  belongs_to :materia
  has_many :puntajes
  delegate :area, :curso_id, :docente_id, :materia, to: :materia, prefix: true
  validates :etapa, presence: true, length: {minimum: 5, maximum: 20}
  validates :tarea, presence: true, length: {minimum: 5, maximum: 30}
  validates :total_puntos, presence: true
  validates :materia_id, presence: true
end
