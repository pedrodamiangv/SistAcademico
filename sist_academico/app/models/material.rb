class Material < ActiveRecord::Base
  attr_accessible :file, :materia_id
  mount_uploader :file, MaterialUploader
  belongs_to :materia
  delegate :materia, to: :materia, prefix: true
  def nombre_material
  	file.to_s.split('/')[5]
  end
end