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

ActiveRecord::Schema.define(:version => 20130113234143) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "scraps_count"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "cities", :force => true do |t|
    t.string   "city",       :limit => 15
    t.string   "state",      :limit => 2
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

  create_table "collection_items", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "scrap_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "collection_items", ["collection_id", "scrap_id"], :name => "index_collection_items_on_collection_id_and_scrap_id"

  create_table "collection_vendors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "collections", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "collection_items_count", :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "collections", ["name"], :name => "index_collections_on_name"

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

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.integer  "scrap_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "keywords", ["name"], :name => "index_keywords_on_name"

  create_table "keywords_scraps", :id => false, :force => true do |t|
    t.integer "keyword_id"
    t.integer "scrap_id"
  end

  add_index "keywords_scraps", ["keyword_id", "scrap_id"], :name => "index_keywords_scraps_on_keyword_id_and_scrap_id"

  create_table "product_listings", :force => true do |t|
    t.integer  "vendor_id"
    t.integer  "scrap_id"
    t.string   "url"
    t.string   "metro_area"
    t.integer  "price",      :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "product_listings", ["vendor_id", "scrap_id"], :name => "index_product_listings_on_vendor_id_and_scrap_id"

  create_table "scraps", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "category_id"
    t.string   "name",               :default => ""
    t.string   "source",             :default => ""
    t.text     "description"
    t.integer  "number_of_shares",   :default => 0
    t.boolean  "item_availability",  :default => false
    t.boolean  "visibility",         :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "scraps", ["creator_id"], :name => "index_scraps_on_creator_id"

  create_table "scraps_tags", :id => false, :force => true do |t|
    t.integer "scrap_id"
    t.integer "tag_id"
  end

  add_index "scraps_tags", ["scrap_id", "tag_id"], :name => "index_scraps_tags_on_scrap_id_and_tag_id"

  create_table "shared_scraps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bookmarked_scrap_id"
    t.text     "notes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "shared_scraps", ["user_id", "bookmarked_scrap_id"], :name => "index_shared_scraps_on_user_id_and_bookmarked_scrap_id"

  create_table "tab_items", :force => true do |t|
    t.integer  "tab_id"
    t.integer  "scrap_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tab_items", ["tab_id", "scrap_id"], :name => "index_tab_items_on_tab_id_and_scrap_id"

  create_table "tabs", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "tab_items_count", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "tabs", ["name"], :name => "index_tabs_on_name"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "scrap_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 25
    t.string   "last_name",           :limit => 50
    t.string   "email",                             :default => "",    :null => false
    t.boolean  "email_confirmed",                   :default => false
    t.boolean  "instructed",                        :default => false
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "metro_area",          :limit => 20
    t.string   "zipcode",             :limit => 5
    t.integer  "user_level",                        :default => 1
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

  create_table "vendors", :force => true do |t|
    t.integer  "user_id"
    t.string   "website",             :limit => 50
    t.string   "company",             :limit => 50
    t.string   "company_address",     :limit => 250
    t.string   "zipcode",             :limit => 5
    t.string   "metro_area",          :limit => 50
    t.integer  "phone",               :limit => 8
    t.integer  "field",               :limit => 8
    t.integer  "number_of_listings",                 :default => 0
    t.integer  "rating",              :limit => 2,   :default => 0
    t.string   "business_type",       :limit => 250
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "price",                              :default => 1
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "vision_boards", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
