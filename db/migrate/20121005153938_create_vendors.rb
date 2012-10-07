class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.references :user
      t.string :website, :limit => 50
      t.string :company, :limit => 50
      t.string :company_address, :limit => 250
      t.integer :phone, :limit => 20
      t.integer :number_of_listings, :default => 0
      t.integer :rating, :default => 0, :limit => 1
      t.timestamps
    end
    
    create_table :cities_vendors, :id => false do |t|
      t.integer :city_id
      t.integer :vendor_id
    end
    
  end
end
