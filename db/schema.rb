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

ActiveRecord::Schema.define(version: 20161117100446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "categories_restrictions", force: :cascade do |t|
    t.integer "category_id"
    t.integer "restriction_id"
  end

  create_table "contact_details", force: :cascade do |t|
    t.string  "contact_name"
    t.string  "contact_email"
    t.string  "contact_phone"
    t.string  "dfr_contact_name"
    t.string  "dfr_contact_email"
    t.string  "dfr_contact_office_phone"
    t.string  "dfr_contact_cell_phone"
    t.string  "dfr_preffered_contact_method"
    t.integer "receiver_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "name"
  end

  create_table "contributions_logistics", force: :cascade do |t|
    t.integer "logistic_id"
    t.integer "contribution_id"
  end

  create_table "demographics", force: :cascade do |t|
    t.string  "percent_male"
    t.string  "percent_female"
    t.string  "percent_other_gender"
    t.string  "percent_youth"
    t.string  "percent_adult"
    t.string  "percent_senior"
    t.string  "percent_american_native"
    t.string  "percent_african_american"
    t.string  "percent_asian"
    t.string  "percent_hispanic"
    t.string  "percent_pacific_islander"
    t.string  "percent_white"
    t.string  "percent_portuguese"
    t.string  "percent_single_no_kids"
    t.string  "percent_single_with_kids"
    t.string  "percentage_married_no_kids"
    t.string  "percentage_married_with_kids"
    t.string  "precent_employed"
    t.string  "percent_unemployed"
    t.string  "percent_veteran_military"
    t.string  "percent_active_military"
    t.string  "percentage_with_dietary_restrictions"
    t.integer "total_guests_served_per_week"
    t.integer "meals_served_per_breakfast"
    t.integer "meals_served_per_lunch"
    t.integer "meals_served_per_dinner"
    t.integer "total_receiving_groceries"
    t.string  "mode_of_transportation"
    t.string  "distance_traveled"
    t.integer "receiver_id"
  end

  create_table "dietary_restrictions", force: :cascade do |t|
    t.string "name"
  end

  create_table "dietary_restrictions_programs", force: :cascade do |t|
    t.integer "program_id"
    t.integer "dietary_restriction_id"
  end

  create_table "donation_items", force: :cascade do |t|
    t.integer "food_id"
    t.integer "quantity"
    t.string  "quantity_type"
    t.integer "donation_id"
  end

  add_index "donation_items", ["donation_id"], name: "index_donation_items_on_donation_id", using: :btree

  create_table "donation_schedules", force: :cascade do |t|
    t.integer "receiver_id"
    t.integer "day_of_week"
    t.integer "open_at_hour"
    t.integer "open_at_minute"
    t.integer "close_at_hour"
    t.integer "close_at_minute"
  end

  create_table "donations", force: :cascade do |t|
    t.integer  "receiver_id"
    t.integer  "donor_id"
    t.string   "tracking_code"
    t.datetime "received_at"
    t.datetime "donated_at"
    t.datetime "confirmed_by_donor_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["receiver_id", "donor_id"], name: "index_donations_on_receiver_id_and_donor_id", using: :btree

  create_table "donors", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "donors", ["email"], name: "index_donors_on_email", unique: true, using: :btree
  add_index "donors", ["reset_password_token"], name: "index_donors_on_reset_password_token", unique: true, using: :btree

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "storage_temp"
    t.boolean  "prepared_meal"
    t.integer  "donor_id"
    t.integer  "category_id"
    t.datetime "deleted_at"
  end

  add_index "foods", ["deleted_at"], name: "index_foods_on_deleted_at", using: :btree

  create_table "logistics", force: :cascade do |t|
    t.integer "receiver_id"
    t.string  "transportation_available"
    t.string  "driver_status"
    t.string  "insurance_status"
    t.string  "vehicle_style"
    t.string  "freezer_type"
    t.string  "refrigerator_type"
    t.string  "indoor_dry_storage"
    t.string  "safe_handling_program"
    t.string  "meal_usage"
    t.string  "meal_distribution_frequency"
  end

  create_table "programs", force: :cascade do |t|
    t.integer "receiver_id"
    t.string  "perishable_food_distribution"
    t.string  "charge_for_service"
    t.string  "meal_style"
    t.integer "staff_size"
    t.string  "food_type_provided"
  end

  create_table "receivers", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "agency_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "tax_id"
    t.boolean  "paused",                 default: false
  end

  add_index "receivers", ["email"], name: "index_receivers_on_email", unique: true, using: :btree
  add_index "receivers", ["reset_password_token"], name: "index_receivers_on_reset_password_token", unique: true, using: :btree

  create_table "restrictions", force: :cascade do |t|
    t.integer "category_id"
    t.integer "receiver_id"
  end

  create_table "restrictions_storage_temps", force: :cascade do |t|
    t.integer "restriction_id"
    t.integer "storage_temp_id"
  end

  create_table "storage_temps", force: :cascade do |t|
    t.string "description"
  end

end
