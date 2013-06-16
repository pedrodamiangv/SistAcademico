class Curso < ActiveRecord::Base
  attr_accessible :curso, :enfasis, :nivel, :turno
  has_many :alumnos
  has_many :materias
  delegate :area, :materia, to: :materia, prefix: true
  validates :curso, presence: true, length: {minimum: 5, maximum: 20}, uniqueness: true, :format => { :with => /\A[a-zA-Z]+\z/ }
  validates :enfasis, presence: true, length: {minimum: 5, maximum: 50}
  validates :nivel, presence: true, length: {minimum: 5, maximum: 30}
  validates :turno, presence: true, length: { maximum: 10 }
end
