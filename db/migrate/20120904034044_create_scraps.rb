class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.references :creator, :class_name => 'User', :foreign_key => 'user_id'
      t.string :name, :default => ''
      t.text :description
      t.integer :number_of_shares, :default => 0
      t.boolean :item_availability, :default => false
      t.boolean :visibility, :default => true
      t.attachment :photo
      t.timestamps
    end
    add_index('scraps', 'creator_id')
  end 
end
