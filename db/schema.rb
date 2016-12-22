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

ActiveRecord::Schema.define(version: 20180313052221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "account_groups", ["name"], name: "index_account_groups_on_name", unique: true, using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "name",             limit: 255,                                          null: false
    t.string   "number",           limit: 255,                                          null: false
    t.string   "type",             limit: 255,                                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "balance",                      precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "account_group_id"
    t.boolean  "archived",                                              default: false, null: false
  end

  add_index "accounts", ["number"], name: "index_accounts_on_number", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "type",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "goals", force: :cascade do |t|
    t.integer  "category_id",                                                        null: false
    t.decimal  "amount",                  precision: 10, scale: 2, default: 0.0,     null: false
    t.string   "period",      limit: 255,                          default: "Month", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                             default: "Spend", null: false
  end

  add_index "goals", ["category_id"], name: "index_goals_on_category_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "name",        limit: 255,                                            null: false
    t.integer  "category_id",                                                        null: false
    t.decimal  "amount",                  precision: 10, scale: 2,                   null: false
    t.string   "type",        limit: 255,                          default: "Spend", null: false
    t.text     "schedule",                                                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["category_id"], name: "index_payments_on_category_id", using: :btree

  create_table "saved_searches", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "query"
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "date_from"
    t.datetime "date_to"
    t.string   "period_from"
    t.string   "period_to"
    t.integer  "tag_ids",                                 array: true
    t.integer  "account_id"
    t.string   "review",        default: "", null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "saved_searches", ["name"], name: "index_saved_searches_on_name", unique: true, using: :btree

  create_table "sorted_transactions", force: :cascade do |t|
    t.string   "name",           limit: 255,                 null: false
    t.integer  "transaction_id",                             null: false
    t.integer  "category_id",                                null: false
    t.integer  "account_id",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "review",                     default: false, null: false
    t.integer  "tag_ids",                                                 array: true
    t.text     "note"
  end

  add_index "sorted_transactions", ["account_id"], name: "index_sorted_transactions_on_account_id", using: :btree
  add_index "sorted_transactions", ["category_id"], name: "index_sorted_transactions_on_category_id", using: :btree
  add_index "sorted_transactions", ["transaction_id"], name: "index_sorted_transactions_on_transaction_id", using: :btree

  create_table "sorting_rules", force: :cascade do |t|
    t.string   "contains",    limit: 255,                 null: false
    t.string   "name",        limit: 255
    t.integer  "category_id",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "review",                  default: false, null: false
    t.integer  "tag_ids",                                              array: true
  end

  add_index "sorting_rules", ["category_id"], name: "index_sorting_rules_on_category_id", using: :btree
  add_index "sorting_rules", ["contains"], name: "index_sorting_rules_on_contains", unique: true, using: :btree

  create_table "statements", force: :cascade do |t|
    t.integer  "account_id",                          null: false
    t.decimal  "balance",    precision: 10, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from_date"
    t.date     "to_date"
  end

  add_index "statements", ["account_id"], name: "index_statements_on_account_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "transactions", force: :cascade do |t|
    t.decimal  "amount",                   precision: 10, scale: 2, null: false
    t.string   "fit_id",       limit: 255,                          null: false
    t.string   "memo",         limit: 255
    t.string   "name",         limit: 255
    t.string   "payee",        limit: 255
    t.datetime "posted_at",                                         null: false
    t.string   "ref_number",   limit: 255
    t.string   "type",         limit: 255
    t.integer  "account_id",                                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "statement_id"
    t.string   "search",       limit: 255,                          null: false
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree
  add_index "transactions", ["statement_id"], name: "index_transactions_on_statement_id", using: :btree

end
