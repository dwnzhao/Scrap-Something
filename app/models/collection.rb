class Collection < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many :collection_items
  has_many :scraps, :through => :collection_items
  
  belongs_to :user
  
end
