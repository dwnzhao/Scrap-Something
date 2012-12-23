class CreateVisionBoardItems < ActiveRecord::Migration
  def change
    create_table :vision_board_items do |t|

      t.timestamps
    end
  end
end
