class CreateCollectionItems < ActiveRecord::Migration
  def change
    create_table :collection_items do |t|
      t.references :collection
      t.references :scrap

      t.timestamps
    end
    
    add_index :collection_items, ['collection_id', 'scrap_id']
  
  end
end
