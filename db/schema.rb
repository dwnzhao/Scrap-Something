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

ActiveRecord::Schema.define(:version => 20120905061201) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "scraps_count", :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categories_scraps", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "scrap_id"
  end

  add_index "categories_scraps", ["category_id", "scrap_id"], :name => "index_categories_scraps_on_category_id_and_scrap_id"

  create_table "pockets", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "pockets_scraps", :id => false, :force => true do |t|
    t.integer "pocket_id"
    t.integer "scrap_id"
  end

  add_index "pockets_scraps", ["pocket_id", "scrap_id"], :name => "index_pockets_scraps_on_pocket_id_and_scrap_id"

  create_table "scraps", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name",               :default => ""
    t.text     "description"
    t.integer  "number_of_shares",   :default => 0
    t.boolean  "item_availability",  :default => false
    t.boolean  "visibility",         :default => true
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "scraps", ["creator_id"], :name => "index_scraps_on_creator_id"

  create_table "shared_scraps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bookmarked_scrap_id"
    t.text     "notes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "shared_scraps", ["user_id", "bookmarked_scrap_id"], :name => "index_shared_scraps_on_user_id_and_bookmarked_scrap_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 25
    t.string   "last_name",           :limit => 50
    t.string   "user_name",                         :default => "",    :null => false
    t.string   "email",                             :default => "",    :null => false
    t.boolean  "email_confirmed",                   :default => false
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "website",             :limit => 50
    t.string   "company",             :limit => 50
    t.string   "metro_area",          :limit => 20
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["user_name"], :name => "index_users_on_user_name"

end