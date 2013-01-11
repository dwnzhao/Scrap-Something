class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :scraps
  
  def self.all
    Category.order('name ASC').all
  end
  
end
