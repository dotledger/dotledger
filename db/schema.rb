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

ActiveRecord::Schema.define(version: 20130901204826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name",                                              null: false
    t.string   "number",                                            null: false
    t.string   "type",                                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "balance",    precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "accounts", ["number"], name: "index_accounts_on_number", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.string   "type",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "sorted_transactions", force: true do |t|
    t.string   "name",           null: false
    t.integer  "transaction_id", null: false
    t.integer  "category_id"
    t.integer  "account_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sorted_transactions", ["account_id"], name: "index_sorted_transactions_on_account_id", using: :btree
  add_index "sorted_transactions", ["category_id"], name: "index_sorted_transactions_on_category_id", using: :btree
  add_index "sorted_transactions", ["transaction_id"], name: "index_sorted_transactions_on_transaction_id", using: :btree

  create_table "sorting_rules", force: true do |t|
    t.string   "contains",    null: false
    t.string   "name"
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sorting_rules", ["category_id"], name: "index_sorting_rules_on_category_id", using: :btree
  add_index "sorting_rules", ["contains"], name: "index_sorting_rules_on_contains", unique: true, using: :btree

  create_table "statements", force: true do |t|
    t.integer  "account_id",                          null: false
    t.decimal  "balance",    precision: 10, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from_date"
    t.date     "to_date"
  end

  add_index "statements", ["account_id"], name: "index_statements_on_account_id", using: :btree

  create_table "transactions", force: true do |t|
    t.decimal  "amount",       precision: 10, scale: 2, null: false
    t.string   "fit_id",                                null: false
    t.string   "memo"
    t.string   "name"
    t.string   "payee"
    t.datetime "posted_at",                             null: false
    t.string   "ref_number"
    t.string   "type"
    t.integer  "account_id",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "statement_id"
    t.string   "search",                                null: false
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree
  add_index "transactions", ["statement_id"], name: "index_transactions_on_statement_id", using: :btree

end
