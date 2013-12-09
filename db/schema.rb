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

ActiveRecord::Schema.define(:version => 20131209174328) do

  create_table "books", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["url"], :name => "index_pages_on_url", :unique => true

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.integer  "book_id"
    t.integer  "weight",             :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "photos", ["book_id"], :name => "index_photos_on_book_id"
  add_index "photos", ["weight"], :name => "index_photos_on_weight"

  create_table "settings", :force => true do |t|
    t.string "name",        :limit => 64, :null => false
    t.string "value"
    t.text   "description"
  end

  add_index "settings", ["name"], :name => "index_settings_on_name", :unique => true

end
