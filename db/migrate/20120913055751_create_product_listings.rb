class CreateProductListings < ActiveRecord::Migration
    def change
      create_table :product_listings do |t|
        t.references :vendor, :class_name => 'User', :foreign_key => 'vendor_id'
        t.references :scrap
        t.string :url
        t.string :metro_area
        t.integer :price
        t.integer :discount_percent
        t.timestamps
      end
      add_index :product_listings, ['vendor_id', 'scrap_id']
    end
  end
