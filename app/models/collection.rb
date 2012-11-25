class Collection < ActiveRecord::Base 
  # attr_accessible :title, :body
  
  has_many :collection_items
  has_many :scraps, :through => :collection_items

  belongs_to :user

  def self.uploaded
   find_by_name('uploaded')
  end  

  def self.external
    find_by_name('external')
  end

  def self.bookmarked
    find_by_name('bookmarked')
  end

  def self.favorite
    find_by_name('favorite')
  end
end
