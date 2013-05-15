class Administrativo < ActiveRecord::Base
  attr_accessible :cargo, :user_id, :titulo
  belongs_to :user
  validates :user_id, presence: true
  validates :cargo, presence: true, length: {minimum: 5, maximum: 30}
  validates :titulo, presence: true, length: {minimum: 5, maximum: 30}
end
