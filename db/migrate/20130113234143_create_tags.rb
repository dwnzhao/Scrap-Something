class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :scrap_count
      t.timestamps
    end

    create_table :scraps_tags, :id => false do |t|
      t.integer :scrap_id
      t.integer :tag_id
    end

    add_index :scraps_tags, ['scrap_id', 'tag_id']

    add_index("tags", "name")

  end
end
