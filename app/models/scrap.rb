class Scrap < ActiveRecord::Base
  attr_accessible :name, :photo, :description, :number_of_shares, :item_availability, :visibility

  has_attached_file :photo, :styles => { :medium => "200x300#", :thumb => "100x100" }
  
  validates :creator_id, :presence => true
  validates :name, :presence => true, :length => {:maximum => 25}, :uniqueness => {:scope => :creator_id}
  validates :photo, :attachment_presence => true
  
  has_and_belongs_to_many :pockets
  has_and_belongs_to_many :categories
  has_many :shared_scraps, :class_name => 'SharedScrap', :foreign_key => 'bookmarked_scrap_id'
  has_many :users, :through => :shared_scraps
  belongs_to :creator, :class_name => 'User'

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

  
end
