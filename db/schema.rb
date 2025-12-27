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

ActiveRecord::Schema[8.1].define(version: 2025_12_27_182513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "day_of_week"
    t.datetime "end_time"
    t.boolean "recurring"
    t.datetime "start_time"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "end_time"
    t.bigint "game_id", null: false
    t.bigint "gamer_id", null: false
    t.text "notes"
    t.datetime "start_time"
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_bookings_on_game_id"
    t.index ["gamer_id", "start_time"], name: "index_bookings_on_gamer_id_and_start_time"
    t.index ["gamer_id"], name: "index_bookings_on_gamer_id"
    t.index ["user_id", "start_time"], name: "index_bookings_on_user_id_and_start_time"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "name"
    t.string "platform"
    t.datetime "updated_at", null: false
  end

  create_table "user_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.string "skill_level"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_user_games_on_game_id"
    t.index ["user_id"], name: "index_user_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id"
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "epic_handle"
    t.string "psn_handle"
    t.string "steam_handle"
    t.string "timezone"
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "xbox_handle"
    t.index ["account_id"], name: "index_users_on_account_id"
  end

  add_foreign_key "availabilities", "users"
  add_foreign_key "bookings", "games"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "users", column: "gamer_id"
  add_foreign_key "user_games", "games"
  add_foreign_key "user_games", "users"
  add_foreign_key "users", "accounts"
end
