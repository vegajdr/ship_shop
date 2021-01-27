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

ActiveRecord::Schema.define(version: 2021_01_25_200129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_locations_on_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "sku"
    t.decimal "price", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["sku"], name: "index_products_on_sku"
  end

  create_table "purchase_order_lines", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 1
    t.decimal "amount", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_purchase_order_lines_on_order_id"
    t.index ["product_id"], name: "index_purchase_order_lines_on_product_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_purchase_orders_on_location_id"
  end

  create_table "stock_level_defaults", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_stock_level_defaults_on_location_id"
    t.index ["product_id"], name: "index_stock_level_defaults_on_product_id"
  end

  create_table "stock_quantities", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_stock_quantities_on_location_id"
    t.index ["product_id"], name: "index_stock_quantities_on_product_id"
  end

  add_foreign_key "purchase_order_lines", "products"
  add_foreign_key "purchase_order_lines", "purchase_orders", column: "order_id"
  add_foreign_key "purchase_orders", "locations"
  add_foreign_key "stock_level_defaults", "locations"
  add_foreign_key "stock_level_defaults", "products"
  add_foreign_key "stock_quantities", "locations"
  add_foreign_key "stock_quantities", "products"
end
