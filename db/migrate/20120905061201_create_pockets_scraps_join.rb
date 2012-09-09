class CreatePocketsScrapsJoin < ActiveRecord::Migration
    def up
      create_table :pockets_scraps, :id => false do |t|
        t.integer "pocket_id"
        t.integer "scrap_id"
      end
      add_index :pockets_scraps, ["pocket_id", "scrap_id"]
    end

    def down
      drop_table :pockets_scraps
    end
  end

