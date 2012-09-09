class CreateCategoriesScrapsJoin < ActiveRecord::Migration
  def up
    create_table :categories_scraps, :id => false do |t|
      t.integer "category_id"
      t.integer "scrap_id"
    end
    add_index :categories_scraps, ["category_id", "scrap_id"]
  end

  def down
    drop_table :categories_scraps
  end
end
