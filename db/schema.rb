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

ActiveRecord::Schema.define(version: 20160316075233) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "number",                         null: false
    t.integer  "kind",            default: 0,    null: false
    t.integer  "status",          default: 0,    null: false
    t.integer  "rent"
    t.date     "date_signed"
    t.date     "date_terminated"
    t.boolean  "auto_updating",   default: true, null: false
    t.text     "note"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "contracts", ["auto_updating"], name: "index_contracts_on_auto_updating", using: :btree
  add_index "contracts", ["kind"], name: "index_contracts_on_kind", using: :btree
  add_index "contracts", ["status"], name: "index_contracts_on_status", using: :btree
  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "contract_id",  null: false
    t.date     "payday",       null: false
    t.integer  "amount",       null: false
    t.date     "date_started"
    t.date     "date_ended"
    t.text     "message"
    t.text     "note"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "payments", ["contract_id"], name: "index_payments_on_contract_id", using: :btree

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

end
