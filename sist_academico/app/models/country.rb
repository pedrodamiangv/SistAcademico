class Country < ActiveRecord::Base
  attr_accessible :pais
  has_many :cities
end
