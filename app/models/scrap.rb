class Scrap < ActiveRecord::Base
  attr_accessible :name, :photo, :description, :number_of_shares, :item_availability, :visibility

  has_attached_file :photo, :styles => { :medium => "200x300#", :thumb => "50x50#" }
  
  validates :creator_id, :presence => true
  validates :photo, :attachment_presence => {:message => "must upload an image"}
  validates :name, :presence => {:message => "is required"}, :length => {:maximum => 25}, :uniqueness => {:scope => :creator_id}
  
  has_many :images, :dependent => :destroy 
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :collections
  has_many :share_scraps, :class_name => 'ShareScrap', :foreign_key => 'bookmarked_scrap_id'
  has_many :users, :through => :share_scraps
  has_many :product_listings, :dependent => :destroy
  belongs_to :creator, :class_name => 'User'

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
  
end
