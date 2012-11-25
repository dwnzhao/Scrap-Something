class CreateVisionBoards < ActiveRecord::Migration
  def change
    create_table :vision_boards do |t|

      t.timestamps
    end
  end
end
