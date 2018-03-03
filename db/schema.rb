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

ActiveRecord::Schema.define(version: 20180303063214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
