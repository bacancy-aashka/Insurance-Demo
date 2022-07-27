# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_27_115319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.text "address"
    t.string "postal_code"
    t.string "city"
    t.string "province"
    t.integer "type"
    t.bigint "quotation_id"
    t.bigint "transaction_info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quotation_id"], name: "index_addresses_on_quotation_id"
    t.index ["transaction_info_id"], name: "index_addresses_on_transaction_info_id"
  end

  create_table "callback_informations", force: :cascade do |t|
    t.integer "phone_number"
    t.integer "call_availability"
    t.bigint "transaction_info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["transaction_info_id"], name: "index_callback_informations_on_transaction_info_id"
  end

  create_table "card_informations", force: :cascade do |t|
    t.string "postal_code"
    t.string "email"
    t.string "card_name"
    t.integer "cvv"
    t.integer "card_number"
    t.date "expiry_date"
    t.bigint "transaction_info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["transaction_info_id"], name: "index_card_informations_on_transaction_info_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.float "eval_value"
    t.float "insurance_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_infos", force: :cascade do |t|
    t.integer "language"
    t.string "home_owner_1"
    t.string "home_owner_2"
    t.string "home_owner_3"
    t.integer "property_type"
    t.boolean "property_owner", default: false
    t.date "purchase_date"
    t.text "lot_number"
    t.boolean "bound_water"
    t.boolean "muncipal_water"
    t.boolean "insurance_issued"
    t.boolean "insurance_denied"
    t.text "note"
    t.string "agent_name"
    t.string "agent_email"
    t.bigint "quotation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quotation_id"], name: "index_transaction_infos_on_quotation_id"
  end

  add_foreign_key "addresses", "quotations"
  add_foreign_key "callback_informations", "transaction_infos"
  add_foreign_key "card_informations", "transaction_infos"
  add_foreign_key "transaction_infos", "quotations"
end
