class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :user
      t.string :name
      t.integer :scrap_count
      t.timestamps
    end
    
    create_table :collections_scraps, :id => false do |t|
      t.integer :collection_id
      t.integer :scrap_id
    end
    
    add_index :collections_scraps, ['collection_id', 'scrap_id']
    
    add_index(:collections, 'name') 
  end
  
  
end
