class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.references :user
      t.string :name
      t.integer :tab_items_count, :default => 0

      t.timestamps
    end
    add_index(:tabs, 'name') 
    
  end
end
