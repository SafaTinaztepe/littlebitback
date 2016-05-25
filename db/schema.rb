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

ActiveRecord::Schema.define(version: 20160523061730) do

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.string   "objective"
    t.text     "description"
    t.string   "ownership"
    t.string   "category"
    t.string   "comments"
    t.string   "preferred_currency"
    t.string   "location"
    t.string   "website"
    t.float    "rating"
    t.text     "tags"
    t.integer  "votes"
    t.integer  "views",              default: 0
    t.string   "qr_code"
    t.string   "cover_image"
    t.string   "goal"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "campaign_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["campaign_id"], name: "index_comments_on_campaign_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
