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

ActiveRecord::Schema[7.0].define(version: 2022_09_06_173330) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "subscriptions", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 8, scale: 3, default: "0.0", null: false
    t.date "first_payment_date"
    t.text "remarks"
    t.boolean "is_paused", default: false, null: false
    t.string "image_url"
    t.integer "payment_cycle", limit: 2, null: false
    t.integer "payment_method", limit: 2, null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", primary_key: "user_id", id: :string, force: :cascade do |t|
    t.integer "currency", limit: 2, null: false
    t.integer "language", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "users", primary_key: "user_id"
end
