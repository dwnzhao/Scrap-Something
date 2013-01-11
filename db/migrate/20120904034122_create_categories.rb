class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :scraps_count
      t.timestamps
    end
        
    add_index('categories', 'name')
    Category.create(:name => 'hair + makeup')    
    Category.create(:name => 'flowers')
    Category.create(:name => 'dresses')
    Category.create(:name => 'accessories')
    Category.create(:name => 'rings')
    Category.create(:name => 'venues')
    Category.create(:name => 'gifts')
    Category.create(:name => 'cakes')
    Category.create(:name => 'tuxes')
    Category.create(:name => 'photos')
    Category.create(:name => 'decor')
    Category.create(:name => 'invitations')
    Category.create(:name => 'themes')
  end
  
end
