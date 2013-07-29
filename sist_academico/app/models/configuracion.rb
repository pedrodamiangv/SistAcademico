class Configuracion < ActiveRecord::Base
  attr_accessible :ciudad, :departamento, :direccion, :email, :logo, :nombre, :telefono
  mount_uploader :logo, MaterialUploader
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :direccion, presence: true, length: { maximum: 50, minimum: 10 }
  validates :nombre, presence: true, length: { maximum: 100, minimum: 10 }
  validates :ciudad, presence: true, length: { maximum: 30, minimum: 3 }
  validates :departamento, presence: true, length: { maximum: 30, minimum: 5 }
  validates :logo, presence: true
  validates :telefono, presence: true, length: { maximum: 13, minimum:6 }, :format => { :with => /^\(\d{3,4}\)\s\d{6}$/ }
end
