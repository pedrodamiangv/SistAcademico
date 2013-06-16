class City < ActiveRecord::Base
  attr_accessible :city, :country_id
  belongs_to :country
  delegate :pais, to: :country, prefix: true
  has_many :addresses
  validates :city, presence: true, length: { maximum: 50, minimum:3 }, :format => { :with => /\A[a-zA-Z\s]+\z/ }
  validates :country_id, presence: true
end
