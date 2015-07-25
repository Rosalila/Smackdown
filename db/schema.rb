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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150725042638) do

  create_table "dojo_invitations", force: true do |t|
    t.integer  "user_id"
    t.integer  "dojo_id"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dojos", force: true do |t|
    t.string   "name"
    t.string   "main_image"
    t.string   "badge_image"
    t.text     "about"
    t.string   "motto"
    t.text     "schedule"
    t.text     "public_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorited_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_path"
  end

  create_table "meta_images", force: true do |t|
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_rules", force: true do |t|
    t.integer  "rule_id"
    t.integer  "user_id"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rule_groups", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.integer  "rule_group_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smackdown_rules", force: true do |t|
    t.integer  "smackdown_id"
    t.integer  "rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smackdowns", force: true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "judge1_id"
    t.integer  "judge2_id"
    t.integer  "judge1_winner_id"
    t.integer  "judge2_winner_id"
    t.boolean  "player2_accepted"
    t.boolean  "judge1_accepted"
    t.boolean  "judge2_accepted"
    t.text     "judge1_comment"
    t.text     "judge2_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_in_dojos", force: true do |t|
    t.integer  "user_id"
    t.integer  "dojo_id"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_playing_games", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.boolean  "is_playing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
