class AddAttachmentIconToPockets < ActiveRecord::Migration
  def self.up
    change_table :pockets do |t|
      t.has_attached_file :icon
    end
  end

  def self.down
    drop_attached_file :pockets, :icon
  end
end