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

ActiveRecord::Schema.define(version: 20160127043737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "passwords", force: :cascade do |t|
    t.string   "name"
    t.boolean  "val_password", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "patterns", force: :cascade do |t|
    t.string   "score_pattern"
    t.string   "description"
    t.integer  "weight_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "patterns", ["weight_id"], name: "index_patterns_on_weight_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "score"
    t.string   "password_digest"
    t.string   "plain_text_pass"
    t.string   "rating"
  end

  create_table "weights", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "patterns", "weights"
end
