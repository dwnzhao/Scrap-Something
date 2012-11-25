class Scrap < ActiveRecord::Base
  attr_accessible :name, :photo, :description, :number_of_shares, :item_availability, :visibility

  has_attached_file :photo, :styles => { :medium => "200x300#", :thumb => "50x50#" }
  
  validates :creator_id, :presence => true
  validates :photo, :attachment_presence => {:message => "must upload an image"}
  validates :name, :presence => {:message => "is required"}, :length => {:maximum => 25}
  
  has_many :images, :dependent => :destroy 
  has_and_belongs_to_many :categories
  has_many :collection_items
  has_many :collections, :through => :collection_items
  has_many :tab_items
  has_many :tabs, :through => :tab_items

  has_many :product_listings, :dependent => :destroy
  belongs_to :creator, :class_name => 'User'

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
  
  
  def self.public_scraps
   find_all_by_visibility(true, :order => 'updated_at ASC') 
  end
  
  
  def self.owned_scraps(id)
   find_all_by_creator_id(id, :order => 'updated_at DESC') 
  end
  
end
