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

ActiveRecord::Schema.define(:version => 20111219221424) do

  create_table "articles", :force => true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.string   "video_url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "colleges", :force => true do |t|
    t.string    "name"
    t.integer   "conference_id"
    t.string    "permalink"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "smacks_count",      :default => 0, :null => false
    t.integer   "redemptions_count", :default => 0, :null => false
    t.string    "abbrev"
    t.integer   "users_count",       :default => 0
  end

  add_index "colleges", ["conference_id"], :name => "index_colleges_on_conference_id"
  add_index "colleges", ["permalink"], :name => "index_colleges_on_permalink"

  create_table "comments", :force => true do |t|
    t.string    "title",            :limit => 50
    t.text      "comment"
    t.integer   "commentable_id"
    t.string    "commentable_type"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "reports_count",                  :default => 0, :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conferences", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "smacks_count",      :default => 0, :null => false
    t.integer   "redemptions_count", :default => 0, :null => false
    t.string    "division"
    t.string    "permalink"
    t.integer   "weight",            :default => 0
  end

  add_index "conferences", ["division"], :name => "index_conferences_on_division"
  add_index "conferences", ["permalink"], :name => "index_conferences_on_permalink"

  create_table "contact_groups", :force => true do |t|
    t.integer   "user_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "contact_groups_contacts", :id => false, :force => true do |t|
    t.integer   "contact_id"
    t.integer   "contact_group_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "contact_groups_contacts", ["contact_group_id"], :name => "index_contact_groups_contacts_on_contact_group_id"
  add_index "contact_groups_contacts", ["contact_id"], :name => "index_contact_groups_contacts_on_contact_id"

  create_table "contacts", :force => true do |t|
    t.integer   "user_id"
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "deliveries", :force => true do |t|
    t.integer   "post_id"
    t.integer   "user_id"
    t.integer   "college_id"
    t.integer   "recipients"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "maintenances", :force => true do |t|
    t.string   "task"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_posts", :force => true do |t|
    t.integer   "post_id"
    t.string    "url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.string    "video_url"
  end

  create_table "photos", :force => true do |t|
    t.string    "caption"
    t.integer   "post_id"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string    "title"
    t.string    "summary"
    t.string    "type"
    t.boolean   "published"
    t.integer   "postable_id"
    t.string    "postable_type"
    t.integer   "user_id"
    t.integer   "on_frontpage_week"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "reports_count",     :default => 0,     :null => false
    t.integer   "up_votes",          :default => 0,     :null => false
    t.integer   "down_votes",        :default => 0,     :null => false
    t.boolean   "contest",           :default => false
  end

  add_index "posts", ["postable_id"], :name => "index_posts_on_postable_id"
  add_index "posts", ["postable_type"], :name => "index_posts_on_postable_type"
  add_index "posts", ["type"], :name => "index_posts_on_type"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string    "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reasons", :force => true do |t|
    t.string    "reason"
    t.timestamp "created_at"
    t.timestamp "updated_at"
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
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id"
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reports", :force => true do |t|
    t.integer   "user_id"
    t.integer   "reportable_id"
    t.string    "reportable_type"
    t.integer   "reason_id"
    t.string    "custom_reason"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "reports", ["reportable_id"], :name => "index_reports_on_reportable_id"
  add_index "reports", ["reportable_type"], :name => "index_reports_on_reportable_type"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "services", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.string    "uname"
    t.string    "uemail"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string    "session_id", :null => false
    t.text      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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

  create_table "statistics", :force => true do |t|
    t.integer   "post_id"
    t.string    "name"
    t.string    "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",                                                     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "college_id"
    t.string   "affiliation"
    t.integer  "up_votes"
    t.integer  "down_votes"
    t.string   "encrypted_password",     :limit => 128,                     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "censor_text",                           :default => true
    t.string   "gender",                 :limit => 1
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "posts_count",                           :default => 0
    t.integer  "deliveries_count",                      :default => 0
    t.string   "role",                                  :default => "user"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "videos", :force => true do |t|
    t.integer   "post_id"
    t.string    "url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.boolean   "vote",          :default => false
    t.integer   "voteable_id",                      :null => false
    t.string    "voteable_type",                    :null => false
    t.integer   "voter_id"
    t.string    "voter_type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

  create_table "votings", :force => true do |t|
    t.string    "voteable_type"
    t.integer   "voteable_id"
    t.string    "voter_type"
    t.integer   "voter_id"
    t.boolean   "up_vote",       :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
