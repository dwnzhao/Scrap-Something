class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :scrap_count
      t.timestamps
    end
    
    create_table :categories_scraps, :id => false do |t|
      t.integer :category_id
      t.integer :scrap_id
    end
    
    add_index :categories_scraps, ['category_id', 'scrap_id']
    
    add_index('categories', 'name')
    Category.create(:name => 'dress')    
    Category.create(:name => 'accessories')
    Category.create(:name => 'cake')
    Category.create(:name => 'decor')
    Category.create(:name => 'stationery')
    Category.create(:name => 'venue')
  end
  
end
