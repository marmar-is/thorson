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

ActiveRecord::Schema.define(version: 20150722171514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree

  create_table "allied_rates", force: :cascade do |t|
    t.integer  "rate"
    t.string   "state"
    t.string   "category"
    t.text     "elements",   default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "allied_rates", ["elements"], name: "index_allied_rates_on_elements", using: :gin

  create_table "brokers", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "brokers", ["email"], name: "index_brokers_on_email", unique: true, using: :btree

  create_table "claim_factors", force: :cascade do |t|
    t.integer  "policy_year"
    t.decimal  "factor"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ded_factors", force: :cascade do |t|
    t.integer  "deductible"
    t.decimal  "factor"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
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

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "entity_factors", force: :cascade do |t|
    t.decimal  "factor"
    t.string   "entity"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "limit_factors", force: :cascade do |t|
    t.decimal  "factor"
    t.string   "limit"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nas_rates", force: :cascade do |t|
    t.integer  "limit"
    t.integer  "rate"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "risk_factors", force: :cascade do |t|
    t.string   "criteria"
    t.integer  "max_debit"
    t.integer  "max_credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "risk_profiles", force: :cascade do |t|
    t.string   "name",          default: ""
    t.string   "county",        default: ""
    t.string   "state",         default: ""
    t.date     "effective",     default: '1995-11-08'
    t.date     "retro"
    t.string   "specialty",     default: ""
    t.integer  "deductible",    default: 0
    t.string   "limit",         default: ""
    t.string   "limit_nas",     default: ""
    t.boolean  "entity",        default: false
    t.integer  "allied1",       default: 0
    t.integer  "allied2",       default: 0
    t.integer  "allied3",       default: 0
    t.string   "sub_specialty", default: ""
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "specialty_factors", force: :cascade do |t|
    t.string   "spec_name"
    t.decimal  "factor"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "state_rates", force: :cascade do |t|
    t.string   "state"
    t.integer  "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "territory_factors", force: :cascade do |t|
    t.decimal  "factor"
    t.string   "county"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
