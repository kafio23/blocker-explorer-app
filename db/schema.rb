# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_10_180136) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "action_type"
    t.decimal "deposit", precision: 30
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "txn_id"
    t.index ["txn_id"], name: "index_actions_on_txn_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "height", null: false
    t.string "block_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_hash"], name: "index_blocks_on_block_hash", unique: true
    t.index ["height"], name: "index_blocks_on_height", unique: true
  end

  create_table "data_updates", force: :cascade do |t|
    t.integer "job_id"
    t.text "logs"
    t.text "job_errors"
    t.boolean "success", default: false
    t.datetime "started_at", precision: nil
    t.datetime "finished_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_hash", null: false
    t.string "block_hash"
    t.string "sender"
    t.string "receiver"
    t.boolean "success", default: false
    t.decimal "gas_burnt", precision: 30
    t.datetime "time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "block_id"
    t.index ["block_id"], name: "index_transactions_on_block_id"
    t.index ["transaction_hash"], name: "index_transactions_on_transaction_hash", unique: true
  end

  add_foreign_key "actions", "transactions", column: "txn_id"
  add_foreign_key "transactions", "blocks"
end
