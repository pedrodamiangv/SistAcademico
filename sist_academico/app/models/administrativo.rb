class Administrativo < ActiveRecord::Base
  attr_accessible :user_attributes, :cargo, :user_id, :titulo
  belongs_to :user, :autosave => true
  accepts_nested_attributes_for :user
  delegate :CINro, :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id, to: :user, prefix: true
  validates :cargo, presence: true, length: {minimum: 5, maximum: 30}
  validates :titulo, presence: true, length: {minimum: 5, maximum: 30}
  before_save { build_user unless user }
end
