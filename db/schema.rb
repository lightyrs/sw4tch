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

ActiveRecord::Schema.define(:version => 20130228070236) do

  create_table "identities", :force => true do |t|
    t.string   "uid"
    t.string   "bio"
    t.string   "username"
    t.string   "provider"
    t.string   "token"
    t.string   "website"
    t.string   "email"
    t.string   "avatar"
    t.string   "profile_url"
    t.string   "location"
    t.integer  "user_id"
    t.integer  "login_count",  :default => 0
    t.datetime "logged_in_at"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "identities", ["uid", "provider"], :name => "index_identities_on_uid_and_provider", :unique => true
  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "swatchbooks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "swatchbooks", ["user_id"], :name => "index_swatchbooks_on_user_id"

  create_table "swatches", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
    t.text     "css"
    t.text     "scss"
    t.text     "stylus"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "swatches", ["user_id", "name"], :name => "index_swatches_on_user_id_and_name", :unique => true
  add_index "swatches", ["user_id"], :name => "index_swatches_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
