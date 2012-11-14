class CreateProductListings < ActiveRecord::Migration
    def change
      create_table :product_listings do |t|
        t.references :vendor
        t.references :scrap
        t.string :url
        t.string :metro_area
        t.integer :price, :limit => 50, :default => 1
        t.timestamps
      end
      
      create_table :cities_product_listings, :id => false do |t|
        t.integer :city_id
        t.integer :product_listing_id
      end
      
      add_index :product_listings, ['vendor_id', 'scrap_id']
    end
  end
