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

ActiveRecord::Schema.define(:version => 20120321134755) do

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "friend1_id"
    t.integer  "friend2_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "relationships", ["friend1_id", "friend2_id"], :name => "index_relationships_on_friend1_id_and_friend2_id", :unique => true
  add_index "relationships", ["friend1_id"], :name => "index_relationships_on_friend1_id"
  add_index "relationships", ["friend2_id"], :name => "index_relationships_on_friend2_id"

  create_table "thoughts", :force => true do |t|
    t.string   "idea"
    t.string   "timeframe"
    t.string   "timeframe_date"
    t.string   "tag"
    t.string   "note_image"
    t.text     "image_content"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "note_location"
    t.string   "note_link"
    t.string   "note_email"
    t.string   "note_text"
    t.text     "location_content"
    t.text     "link_content"
    t.text     "email_content"
    t.text     "text_content"
    t.boolean  "complete"
  end

  add_index "thoughts", ["created_at"], :name => "index_thoughts_on_created_at"
  add_index "thoughts", ["id"], :name => "index_thoughts_on_id"
  add_index "thoughts", ["idea"], :name => "index_thoughts_on_idea"
  add_index "thoughts", ["tag"], :name => "index_thoughts_on_tag"
  add_index "thoughts", ["timeframe"], :name => "index_thoughts_on_timeframe"
  add_index "thoughts", ["timeframe_date"], :name => "index_thoughts_on_timeframe_date"
  add_index "thoughts", ["user_id"], :name => "index_thoughts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
