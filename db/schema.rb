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

ActiveRecord::Schema.define(version: 20151120034151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "open_periods", force: :cascade do |t|
    t.integer  "pharmacy_id"
    t.string   "day",                                         null: false
    t.time     "time_from",   default: '2000-01-01 09:00:00', null: false
    t.time     "time_to",     default: '2000-01-01 17:00:00', null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "open_periods", ["pharmacy_id"], name: "index_open_periods_on_pharmacy_id", using: :btree

  create_table "pharmacies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "open_periods", "pharmacies"
end
