class Keyword < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :scraps


end
