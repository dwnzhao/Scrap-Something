class CreateCollectionVendors < ActiveRecord::Migration
  def change
    create_table :collection_vendors do |t|

      t.timestamps
    end
  end
end
