class Materia < ActiveRecord::Base
  attr_accessible :area, :curso_id, :docente_id, :materia
  belongs_to :curso
  belongs_to :docente
  validates :curso_id, presence: true
  validates :docente_id, presence: true
  validates :materia, presence: true, length: {minimum: 5, maximum: 30}
  validates :area, length: {minimum: 5, maximum: 30}
end
