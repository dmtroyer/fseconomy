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

ActiveRecord::Schema.define(version: 2018_06_18_143818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircraft_models", force: :cascade do |t|
    t.string "name", null: false
    t.integer "additional_crew"
    t.integer "seats"
    t.integer "cruise_speed"
    t.integer "num_engines"
    t.integer "gph"
    t.integer "fuel_volume"
    t.integer "fuel_type"
    t.integer "mtow"
    t.integer "empty_weight"
    t.decimal "base_price", precision: 11, scale: 2
    t.datetime "last_fse_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icao_code", limit: 4, null: false
    t.decimal "engine_price"
    t.integer "fse_update_frequency", default: 0
    t.boolean "report_for_sale", default: false
    t.index ["fse_update_frequency"], name: "index_aircraft_models_on_fse_update_frequency"
    t.index ["icao_code"], name: "index_aircraft_models_on_icao_code"
    t.index ["name"], name: "index_aircraft_models_on_name"
  end

  create_table "aircrafts", force: :cascade do |t|
    t.string "registration"
    t.bigint "aircraft_model_id"
    t.string "owner"
    t.string "current_airport_id"
    t.string "home_airport_id"
    t.decimal "sale_price"
    t.integer "rental_cost_dry"
    t.integer "rental_cost_wet"
    t.integer "distance_bonus"
    t.integer "rental_time"
    t.string "rented_by"
    t.decimal "fuel_pct"
    t.boolean "needs_repair"
    t.integer "airframe_time"
    t.integer "engine_time"
    t.integer "time_last_100hr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_ifr_equipment", default: false
    t.boolean "has_autopilot", default: false
    t.boolean "has_gps", default: false
    t.decimal "fees_owed"
    t.index ["aircraft_model_id"], name: "index_aircrafts_on_aircraft_model_id"
    t.index ["current_airport_id"], name: "index_aircrafts_on_current_airport_id"
    t.index ["home_airport_id"], name: "index_aircrafts_on_home_airport_id"
  end

  create_table "airports", id: false, force: :cascade do |t|
    t.string "icao_code", limit: 4, null: false
    t.decimal "lat"
    t.decimal "lng"
    t.integer "size"
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "airport_type"
    t.index ["icao_code"], name: "index_airports_on_icao_code", unique: true
  end

  add_foreign_key "aircrafts", "aircraft_models"
end
