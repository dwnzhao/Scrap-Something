class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :city, :limit => 50
      t.string :state, :limit => 50
      t.timestamps
    end
    

    
    
    
  end
end
