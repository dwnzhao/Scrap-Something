class ProductListing < ActiveRecord::Base
    attr_accessible :vendor, :scrap, :url, :metro_area, :price, :discount_percent

    belongs_to :vendor, :class_name => 'User', :foreign_key => 'vendor_id'
    belongs_to :scrap
  end
