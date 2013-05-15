class Docente < ActiveRecord::Base
  attr_accessible :matricula, :titulo, :user_id
  belongs_to :user
  validates :matricula, presence: true, length: {minimum: 5, maximum: 20}, uniqueness: true
  validates :titulo, presence: true, length: {minimum: 5, maximum: 50}
end
