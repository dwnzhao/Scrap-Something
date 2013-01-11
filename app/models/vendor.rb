class Vendor < ActiveRecord::Base
  attr_accessible :website, :company, :company_address, :phone, :business_type, :avatar, :metro_area, :zipcode, :price
  
  validates :phone, :numericality => {:message => 'must be a valid number (no hashes)'}, :allow_nil => true
  validates :zipcode, :numericality => {:message => 'must be a valid number (no hashes)'}, :allow_nil => true 
  
  
  has_attached_file :avatar, :styles => { :medium => '100x100>', :thumb => '50x50>' }
  has_many :product_listings
  belongs_to :user
  
end
