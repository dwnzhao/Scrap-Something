# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121005223034) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "scrap_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categories_scraps", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "scrap_id"
  end

  add_index "categories_scraps", ["category_id", "scrap_id"], :name => "index_categories_scraps_on_category_id_and_scrap_id"

  create_table "cities", :force => true do |t|
    t.string   "city",       :limit => 50
    t.string   "state",      :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "cities_product_listings", :id => false, :force => true do |t|
    t.integer "city_id"
    t.integer "product_listing_id"
  end

  create_table "cities_vendors", :id => false, :force => true do |t|
    t.integer "city_id"
    t.integer "vendor_id"
  end

  create_table "collections", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "scrap_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "collections", ["name"], :name => "index_collections_on_name"

  create_table "collections_scraps", :id => false, :force => true do |t|
    t.integer "collection_id"
    t.integer "scrap_id"
  end

  add_index "collections_scraps", ["collection_id", "scrap_id"], :name => "index_collections_scraps_on_collection_id_and_scrap_id"

  create_table "images", :force => true do |t|
    t.integer  "scrap_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "plans", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_listings", :force => true do |t|
    t.integer  "vendor_id"
    t.integer  "scrap_id"
    t.string   "url"
    t.integer  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_listings", ["vendor_id", "scrap_id"], :name => "index_product_listings_on_vendor_id_and_scrap_id"

  create_table "scraps", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name",               :default => ""
    t.text     "description"
    t.integer  "number_of_shares",   :default => 0
    t.boolean  "item_availability",  :default => false
    t.boolean  "visibility",         :default => true
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "scraps", ["creator_id"], :name => "index_scraps_on_creator_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 25
    t.string   "last_name",           :limit => 50
    t.string   "user_name",                         :default => "",    :null => false
    t.string   "email",                             :default => "",    :null => false
    t.boolean  "email_confirmed",                   :default => false
    t.string   "hashed_password"
    t.string   "password"
    t.string   "salt"
    t.string   "metro_area",          :limit => 20
    t.integer  "user_level",          :limit => 3,  :default => 1
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "users", ["user_name"], :name => "index_users_on_user_name"

  create_table "vendors", :force => true do |t|
    t.integer  "user_id"
    t.string   "website",            :limit => 50
    t.string   "company",            :limit => 50
    t.string   "company_address",    :limit => 250
    t.integer  "phone",              :limit => 20
    t.integer  "number_of_listings",                :default => 0
    t.integer  "rating",             :limit => 1,   :default => 0
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

end
