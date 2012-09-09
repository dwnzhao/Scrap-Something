class SharedScrap < ActiveRecord::Base
  attr_accessible :notes, :user, :bookmarked_scrap
  
  belongs_to :user
  belongs_to :bookmarked_scrap, :class_name => 'Scrap', :foreign_key => 'bookmarked_scrap_id'
end
