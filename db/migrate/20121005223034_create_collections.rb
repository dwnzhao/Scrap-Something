class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :user
      t.string :name
      t.integer :collection_items_count, :default => 0
      t.timestamps
    end
        
    add_index(:collections, 'name') 
  end
  
  
end
