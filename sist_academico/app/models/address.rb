class Address < ActiveRecord::Base
  attr_accessible :barrio, :direccion, :city_id
  belongs_to :city
  has_many :users
end
