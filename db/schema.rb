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

ActiveRecord::Schema.define(version: 2020_06_13_015956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dividends", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "year_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_dividends_on_stock_id"
    t.index ["year_id"], name: "index_dividends_on_year_id"
  end

  create_table "earnings", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "year_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_earnings_on_stock_id"
    t.index ["year_id"], name: "index_earnings_on_year_id"
  end

  create_table "share_prices", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "year_id"
    t.decimal "high_value"
    t.decimal "low_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_share_prices_on_stock_id"
    t.index ["year_id"], name: "index_share_prices_on_year_id"
  end

  create_table "shareholders_equities", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "year_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_shareholders_equities_on_stock_id"
    t.index ["year_id"], name: "index_shareholders_equities_on_year_id"
  end

  create_table "stock_exchanges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string "company_name"
    t.string "ticker_symbol"
    t.bigint "stock_exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_exchange_id"], name: "index_stocks_on_stock_exchange_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "year_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
