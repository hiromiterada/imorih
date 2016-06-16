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

ActiveRecord::Schema.define(version: 20160615214232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.integer  "parking_id", null: false
    t.string   "name",       null: false
    t.integer  "status",     null: false
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "areas", ["parking_id"], name: "index_areas_on_parking_id", using: :btree

  create_table "contract_areas", force: :cascade do |t|
    t.integer  "contract_id", null: false
    t.integer  "area_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contract_areas", ["area_id"], name: "index_contract_areas_on_area_id", using: :btree
  add_index "contract_areas", ["contract_id"], name: "index_contract_areas_on_contract_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.integer  "owner_id",                       null: false
    t.integer  "parking_id"
    t.string   "code",                           null: false
    t.integer  "kind",            default: 0,    null: false
    t.integer  "status",          default: 1,    null: false
    t.integer  "rent",            default: 0,    null: false
    t.date     "date_signed"
    t.date     "date_terminated"
    t.boolean  "auto_updating",   default: true, null: false
    t.text     "note"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "rent_unit",       default: 1,    null: false
  end

  add_index "contracts", ["auto_updating"], name: "index_contracts_on_auto_updating", using: :btree
  add_index "contracts", ["kind"], name: "index_contracts_on_kind", using: :btree
  add_index "contracts", ["owner_id"], name: "index_contracts_on_owner_id", using: :btree
  add_index "contracts", ["parking_id"], name: "index_contracts_on_parking_id", using: :btree
  add_index "contracts", ["status"], name: "index_contracts_on_status", using: :btree
  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id", using: :btree

  create_table "owner_users", force: :cascade do |t|
    t.integer  "owner_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "owner_users", ["owner_id"], name: "index_owner_users_on_owner_id", using: :btree
  add_index "owner_users", ["user_id"], name: "index_owner_users_on_user_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "email",          null: false
    t.string   "address"
    t.string   "phone"
    t.string   "representative"
    t.text     "signature"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "parkings", force: :cascade do |t|
    t.integer  "owner_id",                      null: false
    t.string   "name",                          null: false
    t.string   "code",                          null: false
    t.string   "canonical_name",                null: false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.text     "price"
    t.text     "message"
    t.text     "cautions"
    t.boolean  "is_public",      default: true, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "parkings", ["canonical_name"], name: "index_parkings_on_canonical_name", unique: true, using: :btree
  add_index "parkings", ["code"], name: "index_parkings_on_code", unique: true, using: :btree
  add_index "parkings", ["is_public"], name: "index_parkings_on_is_public", using: :btree
  add_index "parkings", ["owner_id"], name: "index_parkings_on_owner_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "contract_id",                  null: false
    t.date     "payday",                       null: false
    t.integer  "amount",       default: 0,     null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.text     "message"
    t.text     "note"
    t.boolean  "sent_mail",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "payments", ["contract_id"], name: "index_payments_on_contract_id", using: :btree
  add_index "payments", ["sent_mail"], name: "index_payments_on_sent_mail", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "customer_code",                         null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "lastname"
    t.string   "firstname"
    t.integer  "locale",                 default: 0,    null: false
    t.integer  "gender",                 default: 0,    null: false
    t.date     "birthday"
    t.string   "address"
    t.string   "phone"
    t.integer  "role",                   default: 0,    null: false
    t.boolean  "send_of_dm",             default: true, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["customer_code"], name: "index_users_on_customer_code", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["send_of_dm"], name: "index_users_on_send_of_dm", using: :btree

  add_foreign_key "areas", "parkings"
  add_foreign_key "contract_areas", "areas"
  add_foreign_key "contract_areas", "contracts"
  add_foreign_key "contracts", "owners"
  add_foreign_key "contracts", "parkings"
  add_foreign_key "contracts", "users"
  add_foreign_key "owner_users", "owners"
  add_foreign_key "owner_users", "users"
  add_foreign_key "parkings", "owners"
  add_foreign_key "payments", "contracts"
end
