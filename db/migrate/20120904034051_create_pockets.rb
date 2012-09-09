class CreatePockets < ActiveRecord::Migration
  def change
    create_table :pockets do |t|

      t.timestamps
    end
  end
end
