class City < ActiveRecord::Base
  attr_accessible :city, :country_id
  belongs_to :country
  has_many :addresses
end
