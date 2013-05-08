class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :nombre, :apellido, :sexo, :telefono, :fecha_nacimiento, :lugar_nacimiento, :edad, :username, :email, :password, :password_confirmation, :address_id
  belongs_to :address
  before_save { |user| user.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates_confirmation_of :password
  validates :nombre, presence: true, length: { maximum: 50 }
  validates :apellido, presence: true, length: { maximum: 50 }
  validates :sexo, presence: true, length: { maximum: 2 }
  validates :telefono, presence: true, length: { maximum: 50 }
  validates :fecha_nacimiento, presence: true, length: { maximum: 50 }
  validates :lugar_nacimiento, presence: true
  validates :address_id, presence: true, length: { maximum: 50 }
  validates_format_of :fecha_nacimiento, :with => /\A\d{2}(\/|-)\d{2}(\/|-)\d{4}\Z/i, :message => "tiene formato incorrecto"
end
