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

ActiveRecord::Schema.define(:version => 20110725134606) do

  create_table "colleges", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string    "content"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "content_type"
    t.string   "title"
    t.string   "content"
    t.integer  "vote"
    t.integer  "college_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "comments"
    t.integer  "up_votes"
    t.integer  "down_votes"
  end

  create_table "redemptions", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "content_type"
    t.string    "title"
    t.string    "content"
    t.integer   "vote"
    t.integer   "college_id"
    t.integer   "user_id"
    t.string    "post_type"
    t.string    "apost_type"
  end

  create_table "relationships", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "smacks", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "content_type"
    t.string    "title"
    t.string    "content"
    t.integer   "vote"
    t.integer   "college_id"
    t.integer   "user_id"
    t.string    "post_type"
    t.string    "apost_type"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "encrypted_password"
    t.string    "salt"
    t.boolean   "admin",              :default => false
    t.string    "username"
    t.string    "first_name"
    t.string    "last_name"
    t.integer   "up_votes"
    t.integer   "down_votes"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
