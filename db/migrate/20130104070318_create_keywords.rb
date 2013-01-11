class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :scrap_count
      t.timestamps
    end

    create_table :keywords_scraps, :id => false do |t|
      t.integer :keyword_id
      t.integer :scrap_id
    end

    add_index :keywords_scraps, ['keyword_id', 'scrap_id']

    add_index("keywords", "name")

  end
end