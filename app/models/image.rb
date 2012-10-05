class Image < ActiveRecord::Base  
  
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "200x300#", :thumb => "50x50#" }
  
  belongs_to :scrap
  
end
