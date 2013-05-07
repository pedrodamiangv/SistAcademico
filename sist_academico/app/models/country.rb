class Country < ActiveRecord::Base
  attr_accessible :pais
  has_many :cities
  validates :pais, presence: true, length: { maximum: 30 }
end
