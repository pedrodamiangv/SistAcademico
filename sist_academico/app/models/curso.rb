class Curso < ActiveRecord::Base
  attr_accessible :curso, :enfasis, :nivel, :turno, :tipo, :seccion
  has_many :alumnos
  has_many :materias
  delegate :area, :materia, to: :materia, prefix: true
  validates :curso, presence: true, length: {minimum: 5, maximum: 20}, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :enfasis, presence: true, length: {minimum: 5, maximum: 50}
  validates :nivel, presence: true, length: {minimum: 5, maximum: 30}
  validates :turno, presence: true, length: { maximum: 10 }
  validates :tipo, presence: true, length: { maximum: 10 }
  def curso_grado
    curso = ""
    if self.curso && self.tipo
  	  curso = self.curso + ' ' + self.tipo
    elsif self.curso && !self.tipo
      curso = self.curso
    elsif !self.curso && self.tipo  
      curso = self.tipo
    else
      curso = ""
    end 
    if self.seccion
      curso += " " + self.seccion
    end
    curso
  end

  def curso_grado_sin_seccion
    curso = ""
    if self.curso && self.tipo
      curso = self.curso + ' ' + self.tipo
    elsif self.curso && !self.tipo
      curso = self.curso
    elsif !self.curso && self.tipo  
      curso = self.tipo
    else
      curso = ""
    end 
    curso
  end

  def curso_grado_turno
    if self.turno
      curso_grado + ", T. " + self.turno
    else
      curso_grado + ", T. no registrado"
    end
  end
end
