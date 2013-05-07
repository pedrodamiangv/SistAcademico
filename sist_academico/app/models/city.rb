class City < ActiveRecord::Base
  attr_accessible :city, :country_id
  belongs_to :country
  has_many :addresses
  validates :city, presence: true, length: { maximum: 30 }
  validates :country_id, presence: true
end
