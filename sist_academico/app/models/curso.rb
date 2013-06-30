class Curso < ActiveRecord::Base
  attr_accessible :curso, :enfasis, :nivel, :turno, :tipo
  has_many :alumnos
  has_many :materias
  delegate :area, :materia, to: :materia, prefix: true
  validates :curso, presence: true, length: {minimum: 5, maximum: 20}, uniqueness: true, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :enfasis, presence: true, length: {minimum: 5, maximum: 50}
  validates :nivel, presence: true, length: {minimum: 5, maximum: 30}
  validates :turno, presence: true, length: { maximum: 10 }
  validates :tipo, presence: true, length: { maximum: 10 }
  def curso_grado
    if self.curso && self.tipo
  	  self.curso + ' ' + self.tipo
    elsif self.curso && !self.tipo
      self.curso
    elsif !self.curso && self.tipo  
      self.tipo
    else
      ""
    end 
  end
end
