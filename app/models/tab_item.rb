class TabItem < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :tab, :counter_cache => true
  belongs_to :scrap
  
end
