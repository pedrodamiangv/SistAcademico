class Address < ActiveRecord::Base
  attr_accessible :barrio, :direccion, :city_id
  belongs_to :city
  delegate :city, to: :city, prefix: true
  has_many :users
  validates :barrio, presence: true, length: { maximum: 30 }
  validates :direccion, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :city_id, presence: true
end
