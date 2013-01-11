class Scrap < ActiveRecord::Base
  attr_accessible :name, :photo, :description, :number_of_shares, :item_availability, :visibility

  has_attached_file :photo, :styles => { :medium => "200x300#", :thumb => "50x50#" }
  
  validates :creator_id, :presence => true
  validates :photo, :attachment_presence => {:message => "must upload an image"}
  validates :name, :presence => {:message => "is required"}, :length => {:maximum => 25}
  
  has_many :images, :dependent => :destroy 
  belongs_to :category, :counter_cache => true
  has_and_belongs_to_many :keywords
  has_many :collection_items
  has_many :collections, :through => :collection_items
  has_many :tab_items
  has_many :tabs, :through => :tab_items

  has_many :product_listings, :dependent => :destroy
  belongs_to :creator, :class_name => 'User'

  scope :public_search, lambda {|query| where(["name LIKE ? AND visibility = ?", "%#{query}%", true])}
  scope :private_search, lambda {|query, user_id| where(["name LIKE ? AND creator_id = ?", "%#{query}%", user_id])}
  
  
  def self.public_scraps
   find_all_by_visibility(true, :order => 'updated_at ASC') 
  end
  
  
  def self.owned_scraps(id)
   find_all_by_creator_id(id, :order => 'updated_at DESC') 
  end
  
end
