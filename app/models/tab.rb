class Tab < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many :tab_items
  has_many :scraps, :through => :tab_items
  
  belongs_to :user
  
end
