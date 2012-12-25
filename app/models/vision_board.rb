class VisionBoard < ActiveRecord::Base
  attr_accessible :photo, :name

  has_attached_file :photo
    
  belongs_to :creator, :class_name => 'User'

end
