class Country < ActiveRecord::Base
  attr_accessible :pais
  has_many :cities
  validates :pais, presence: true, length: { maximum: 30, minimum:3 }, :format => { :with => /\A[a-zA-Z\s]+\z/ }, :uniqueness => { :message => "Este pais ya se ha almacenado"}
end
