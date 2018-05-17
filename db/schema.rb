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

ActiveRecord::Schema.define(version: 2018_05_17_185325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircraft_models", force: :cascade do |t|
    t.string "name", null: false
    t.integer "additional_crew"
    t.integer "seats"
    t.integer "passengers"
    t.integer "cruise_speed"
    t.integer "num_engines"
    t.integer "gph"
    t.integer "fuel_volume"
    t.integer "fuel_type"
    t.integer "payload"
    t.decimal "endurance_distance"
    t.decimal "endurance_hours"
    t.decimal "cost_per_nm"
    t.integer "mtow"
    t.integer "empty_weight"
    t.decimal "base_price"
    t.datetime "last_fse_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_aircraft_models_on_name"
  end

  create_table "airports", force: :cascade do |t|
    t.string "code", limit: 4, null: false
    t.decimal "lat"
    t.decimal "lng"
    t.integer "size"
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type"
    t.index ["code"], name: "index_airports_on_code"
  end

end
