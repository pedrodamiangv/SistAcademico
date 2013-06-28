class Preferencia < ActiveRecord::Base
  attr_accessible :codigo, :user_id, :value
  belongs_to :user
end
