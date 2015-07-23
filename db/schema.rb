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

ActiveRecord::Schema.define(version: 20150723174238) do

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
    t.integer  "role",               default: 0
    t.string   "fname",              default: ""
    t.string   "lname",              default: ""
    t.integer  "broker_acct_id"
  end

  add_index "accounts", ["broker_acct_id"], name: "index_accounts_on_broker_acct_id", using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree

  create_table "allied_rates", force: :cascade do |t|
    t.integer  "rate"
    t.string   "group"
    t.text     "constituents", default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "allied_rates", ["constituents"], name: "index_allied_rates_on_constituents", using: :gin

  create_table "base_rates", force: :cascade do |t|
    t.integer  "rate"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "broker_accts", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "code",         default: ""
    t.string   "contact_name", default: ""
    t.string   "email",        default: ""
    t.string   "phone",        default: ""
    t.string   "street",       default: ""
    t.string   "city",         default: ""
    t.string   "state",        default: ""
    t.string   "zip",          default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "broker_accts", ["code"], name: "index_broker_accts_on_code", unique: true, using: :btree

  create_table "ded_factors", force: :cascade do |t|
    t.integer  "deductible"
    t.decimal  "factor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_factors", force: :cascade do |t|
    t.decimal  "factor"
    t.boolean  "entity"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "risk_factors", force: :cascade do |t|
    t.string   "criteria"
    t.decimal  "min_factor"
    t.decimal  "max_factor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "risk_profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "county"
    t.string   "state"
    t.string   "territory"
    t.date     "effective"
    t.date     "retro"
    t.string   "specialty"
    t.string   "specialty_surgery"
    t.integer  "deductible"
    t.string   "limit"
    t.string   "limit_nas"
    t.boolean  "entity"
    t.integer  "allied1"
    t.integer  "allied2"
    t.integer  "allied3"
    t.string   "sub_specialty"
    t.boolean  "capital"
    t.string   "license"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "broker_acct_id"
  end

  add_index "risk_profiles", ["broker_acct_id"], name: "index_risk_profiles_on_broker_acct_id", using: :btree

  create_table "specialty_factors", force: :cascade do |t|
    t.string   "spec_name"
    t.string   "spec_surgery"
    t.string   "spec_class"
    t.string   "spec_code"
    t.decimal  "factor"
    t.string   "state"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "step_factors", force: :cascade do |t|
    t.string   "policy_year"
    t.decimal  "factor"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "territory_factors", force: :cascade do |t|
    t.decimal  "factor"
    t.string   "territory"
    t.integer  "number"
    t.decimal  "exposure"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "broker_accts"
  add_foreign_key "risk_profiles", "broker_accts"
end
