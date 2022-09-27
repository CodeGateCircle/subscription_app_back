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

  create_table "currencies", force: :cascade do |t|
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency"], name: "index_currencies_on_currency", unique: true
  end

  create_table "languages", force: :cascade do |t|
    t.string "language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language"], name: "index_languages_on_language", unique: true
  end

  create_table "payment_cycles", force: :cascade do |t|
    t.string "payment_cycle", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_cycle"], name: "index_payment_cycles_on_payment_cycle", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "payment_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_method"], name: "index_payment_methods_on_payment_method", unique: true
  end

  create_table "subscription_images", force: :cascade do |t|
    t.string "subscription_name", null: false
    t.binary "subscription_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", default: 0, null: false
    t.date "first_payment_date"
    t.text "remarks"
    t.bigint "user_id", null: false
    t.bigint "subscription_image_id", null: false
    t.bigint "payment_cycle_id", null: false
    t.bigint "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_cycle_id"], name: "index_subscriptions_on_payment_cycle_id"
    t.index ["payment_method_id"], name: "index_subscriptions_on_payment_method_id"
    t.index ["subscription_image_id"], name: "index_subscriptions_on_subscription_image_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_users_on_currency_id"
    t.index ["language_id"], name: "index_users_on_language_id"
  end

  add_foreign_key "subscriptions", "payment_cycles"
  add_foreign_key "subscriptions", "payment_methods"
  add_foreign_key "subscriptions", "subscription_images"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "users", "currencies"
  add_foreign_key "users", "languages"
end
