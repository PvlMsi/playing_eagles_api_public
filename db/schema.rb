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

ActiveRecord::Schema.define(version: 2018_09_10_182952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "pitch_id"
    t.datetime "date"
    t.integer "players_quantity"
    t.integer "time_length"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pitch_id"], name: "index_games_on_pitch_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "opinions", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "issuing_user_id"
    t.text "description"
    t.boolean "anonymous", default: false
    t.integer "fair_play_rate"
    t.integer "would_recommend_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issuing_user_id"], name: "index_opinions_on_issuing_user_id"
    t.index ["player_id"], name: "index_opinions_on_player_id"
  end

  create_table "pitches", force: :cascade do |t|
    t.string "city"
    t.string "address"
    t.integer "opening_hour"
    t.integer "closing_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pitches_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pitch_id", null: false
    t.index ["pitch_id", "user_id"], name: "index_pitches_users_on_pitch_id_and_user_id"
    t.index ["user_id", "pitch_id"], name: "index_pitches_users_on_user_id_and_pitch_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "scheduled_events", force: :cascade do |t|
    t.bigint "pitch_id"
    t.bigint "user_id"
    t.date "first_date"
    t.date "last_date"
    t.time "starting_hour"
    t.time "finishing_hour"
    t.integer "interval"
    t.integer "interval_type"
    t.string "description"
    t.boolean "canceled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pitch_id"], name: "index_scheduled_events_on_pitch_id"
    t.index ["user_id"], name: "index_scheduled_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.string "phone_number"
    t.string "city"
    t.string "street"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
