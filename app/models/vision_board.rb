class VisionBoard < ActiveRecord::Base
  attr_accessible :photo

  has_attached_file :photo
    
  belongs_to :creator, :class_name => 'User'

end
