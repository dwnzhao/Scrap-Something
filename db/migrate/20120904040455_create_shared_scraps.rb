class CreateSharedScraps < ActiveRecord::Migration
  def change
    create_table :shared_scraps do |t|
      t.references :user
      t.references :bookmarked_scrap, :class_name => "Scrap", :foreign_key => 'scrap_id'
      t.text "notes"
      t.timestamps
    end
    add_index :shared_scraps, ['user_id', 'bookmarked_scrap_id']
  end
end
