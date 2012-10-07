class Vendor < ActiveRecord::Base
  attr_accessible :website, :company, :company_address, :phone
  
  validates :phone, :numericality => {:message => 'must be a valid number (no hashes)'}, :allow_nil => true
  
  has_many :product_listings
  
  
end
