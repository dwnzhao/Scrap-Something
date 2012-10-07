class Collection < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_and_belongs_to_many :scraps
  belongs_to :user
  
end
