class CreateTabItems < ActiveRecord::Migration
  def change
    create_table :tab_items do |t|
      t.references :tab
      t.references :scrap

      t.timestamps
    end
    
    add_index :tab_items, ['tab_id', 'scrap_id']
    
  end
end
