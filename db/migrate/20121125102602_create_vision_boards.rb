class CreateVisionBoards < ActiveRecord::Migration
  def change
    create_table :vision_boards do |t|
      t.references :creator, :class_name => 'User', :foreign_key => 'user_id'
      t.attachment :photo
      t.timestamps
    end
  end
end
