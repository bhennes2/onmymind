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

ActiveRecord::Schema.define(:version => 20120302173305) do

  create_table "thoughts", :force => true do |t|
    t.string   "idea"
    t.string   "timeframe"
    t.date     "timeframe_date"
    t.string   "tag"
    t.string   "note_type"
    t.text     "note_content"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "thoughts", ["created_at"], :name => "index_thoughts_on_created_at"
  add_index "thoughts", ["id"], :name => "index_thoughts_on_id"
  add_index "thoughts", ["idea"], :name => "index_thoughts_on_idea"
  add_index "thoughts", ["tag"], :name => "index_thoughts_on_tag"
  add_index "thoughts", ["timeframe"], :name => "index_thoughts_on_timeframe"
  add_index "thoughts", ["timeframe_date"], :name => "index_thoughts_on_timeframe_date"
  add_index "thoughts", ["user_id"], :name => "index_thoughts_on_user_id"

end
