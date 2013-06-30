class Docente < ActiveRecord::Base
  attr_accessible :user_attributes, :matricula, :titulo, :user_id
  belongs_to :user, :autosave => true
  has_many :materias
  delegate :area, :materia, to: :materia, prefix: true
  accepts_nested_attributes_for :user
  delegate :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id, to: :user, prefix: true
  validates :matricula, presence: true, length: {minimum: 5, maximum: 15}, uniqueness: true, :format => { :with => /\d/}
  validates :titulo, presence: true, length: {minimum: 5, maximum: 50}, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  before_save { build_user unless user }
  def full_name
    user_nombre.capitalize + ' ' + user_apellido.capitalize
  end
end
