class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :is_docente, :is_administrativo, :is_alumno, :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id
  belongs_to :address
  has_one :alumno
  has_many :preferencias
  accepts_nested_attributes_for :alumno
  has_one :administrativo
  has_one :docente
  before_save { |user| user.email = email.downcase }

  #VALIDACIONES DE LOS CAMPOS
  validates :username, presence: true, length: { maximum: 30, minimum:2 }, :format => { :with => /\A[a-zA-Z\d]+\z/ }, :uniqueness => { :message => "Este nombre de usuario ya existe. "}
  validates :CINro, presence: true, length: { maximum: 9, minimum:6 }, :format => { :with => /^\d{1}\s?\d{3}\s?\d{3}$/ || /^\d{3}\s?\d{3}$/ }, :uniqueness => { :message => "Ya existe un usuario con ese numero de documento"}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }, on: :edit
  validates :password, presence: true, length: { maximum: 20, minimum: 6 }
  validates_confirmation_of :password
  validates :nombre, presence: true, length: { maximum: 50, minimum:3 }, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :apellido, presence: true, length: { maximum: 50, minimum:3 }, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :sexo, presence: true, length: { maximum: 10 }
  validates :telefono, presence: true, length: { maximum: 13, minimum:6 }, :format => { :with => /^\(\d{3,4}\)\s\d{6}$/ }
  validates :fecha_nacimiento, presence: true, length: { maximum: 50 }
  validates :lugar_nacimiento, presence: true
  validates :address_id, presence: true, length: { maximum: 50 }
  validates_format_of :fecha_nacimiento, :with => /\A\d{2}(\/|-)\d{2}(\/|-)\d{4}\Z/i, :message => "*tiene formato incorrecto"
  
  def full_name
   self.nombre.capitalize + ' ' + self.apellido.capitalize
  end
end

  def guardar_address direccion
    if direccion.save
      return true
    end
    return false
  end



