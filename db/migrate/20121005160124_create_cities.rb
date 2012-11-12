class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :city, :limit => 15
      t.string :state, :limit => 2
      t.timestamps
    end
    
    City.create(:city => 'San Francisco', :state => 'CA')    
    City.create(:city => 'New York', :state => 'NY')
    City.create(:city => 'Los Angeles', :state => 'CA')
    City.create(:city => 'Chicago', :state => 'IL')
    City.create(:city => 'Boston', :state => 'MA')
    City.create(:city => 'Washington DC')
    
  end
end
