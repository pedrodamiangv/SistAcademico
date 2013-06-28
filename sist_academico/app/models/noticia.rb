class Noticia < ActiveRecord::Base
  attr_accessible :noticia, :user_id
  belongs_to :user
  delegate :full_name, to: :user, prefix: true
  validates :user_id, presence: true
  validates :noticia, presence: true
end
