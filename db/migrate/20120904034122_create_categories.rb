class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string "name"
      t.integer "scraps_count", :default => 0, :null => false
      t.timestamps
    end
    add_index("categories", "name")
    Category.create(:name => 'dress')    
    Category.create(:name => 'accessories')
    Category.create(:name => 'cake')
    Category.create(:name => 'decor')
    Category.create(:name => 'stationary')
  end
end
