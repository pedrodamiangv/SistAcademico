class Puntaje < ActiveRecord::Base
  attr_accessible :alumno_id, :descripcion, :puntaje, :planificacion_id
  belongs_to :alumno
  belongs_to :planificacion
  delegate :descripcion, :etapa, :fecha_entrega, :materia_id, :tarea, :total_puntos, to: :planificacion, prefix: true
  validates :descripcion,length: { maximum: 100}
  validates :alumno_id, presence: true
  validates :planificacion_id, presence: true
  validates_format_of :puntaje, :with => /^\d+\.*\d{0,2}$/
  validates :puntaje, presence: true, numericality: {only_integer: false, greater_than_or_equal_to: 1, less_than_or_equal_to: :planificacion_total_puntos}
end
