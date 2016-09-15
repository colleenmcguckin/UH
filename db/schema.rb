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

ActiveRecord::Schema.define(version: 20160906045758) do

  create_table "donation_items", force: :cascade do |t|
    t.string  "description"
    t.integer "quantity"
    t.string  "quantity_type"
    t.integer "donation_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer  "receiver_id"
    t.integer  "donor_id"
    t.string   "tracking_code"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "organization_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
