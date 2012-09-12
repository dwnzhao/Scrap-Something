class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :scrap
      t.attachment :image
      t.string :description
      t.timestamps
    end
  end
end
