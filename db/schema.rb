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

ActiveRecord::Schema.define(version: 2020_06_18_084818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "lot_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lot_id"], name: "index_categories_on_lot_id"
  end

  create_table "categories_lots", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "lot_id", null: false
    t.bigint "interesting_category_id"
    t.bigint "interested_lot_id"
    t.index ["interested_lot_id"], name: "index_categories_lots_on_interested_lot_id"
    t.index ["interesting_category_id"], name: "index_categories_lots_on_interesting_category_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "image"
    t.integer "status", default: 0
    t.integer "state"
    t.integer "price"
    t.bigint "category_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_lots_on_category_id"
    t.index ["user_id"], name: "index_lots_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "status"
    t.bigint "requested_lot_id", null: false
    t.bigint "suggested_lot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requested_lot_id"], name: "index_offers_on_requested_lot_id"
    t.index ["suggested_lot_id"], name: "index_offers_on_suggested_lot_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
