class CollectionItem < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :collection, :counter_cache => true
  belongs_to :scrap
  
end
