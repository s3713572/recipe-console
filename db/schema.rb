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

ActiveRecord::Schema.define(version: 2021_06_01_102659) do

  create_table "action_text_rich_texts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "foods", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "food_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img_url", default: "https://recipesharebucket.s3.amazonaws.com/d0b8ee08-433f-486e-b340-a35302fe41a6.jpg", null: false
  end

  create_table "purchase_order_items", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "purchase_order_id"
    t.bigint "food_id", null: false
    t.float "count", default: 1.0
    t.string "unit", default: "gram"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_purchase_order_items_on_food_id"
    t.index ["purchase_order_id"], name: "index_purchase_order_items_on_purchase_order_id"
  end

  create_table "purchase_orders", charset: "utf8mb3", force: :cascade do |t|
    t.string "address", null: false
    t.string "city", default: "Melbourne"
    t.string "customer_name", null: false
    t.string "username", null: false
    t.string "state", default: "Vic", null: false
    t.string "country", default: "Au", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.index ["username"], name: "index_purchase_orders_on_username"
  end

  create_table "recipe_foods", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "food_id"
    t.float "count", default: 1.0
    t.string "unit", default: "grams"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_recipe_foods_on_food_id"
    t.index ["recipe_id"], name: "index_recipe_foods_on_recipe_id"
  end

  create_table "recipes", charset: "utf8mb3", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cover_url", default: "https://recipesharebucket.s3.amazonaws.com/d0b8ee08-433f-486e-b340-a35302fe41a6.jpg", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "purchase_order_items", "foods"
  add_foreign_key "purchase_order_items", "purchase_orders"
end
