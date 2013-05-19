class Curso < ActiveRecord::Base
  attr_accessible :curso, :enfasis, :nivel, :turno
  has_many :alumnos
  has_many :materias
  validates :curso, presence: true, length: {minimum: 5, maximum: 20}, uniqueness: true
  validates :enfasis, presence: true, length: {minimum: 5, maximum: 50}
  validates :nivel, presence: true, length: {minimum: 5, maximum: 30}
  validates :turno, presence: true, length: { maximum: 10 }
end
