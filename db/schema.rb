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

ActiveRecord::Schema.define(version: 20180228161256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.bigint "venue_id"
    t.integer "left_team_id", null: false
    t.integer "right_team_id", null: false
    t.string "phase", null: false
    t.integer "left_team_score"
    t.integer "right_team_score"
    t.datetime "kickoff_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase", "left_team_id", "right_team_id"], name: "index_matches_on_phase_and_left_team_id_and_right_team_id", unique: true
    t.index ["venue_id"], name: "index_matches_on_venue_id"
  end

  create_table "names", id: false, force: :cascade do |t|
    t.integer "part", null: false
    t.string "value", null: false
    t.index ["part", "value"], name: "uk_names_part_name", unique: true
  end

  create_table "predictions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "match_id"
    t.integer "left_team_score"
    t.integer "right_team_score"
    t.integer "points_left_team_score"
    t.integer "points_right_team_score"
    t.integer "points_overall_outcome"
    t.integer "points_goal_difference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points_total"
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id", "match_id"], name: "index_predictions_on_user_id_and_match_id"
    t.index ["user_id"], name: "index_predictions_on_user_id"
  end

  create_table "squad_members", force: :cascade do |t|
    t.integer "squad_id", null: false
    t.integer "user_id", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "invitation_sent_at", null: false
    t.datetime "invitation_accepted_at"
    t.integer "ranking_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id", "user_id"], name: "index_squad_members_on_squad_id_and_user_id", unique: true
  end

  create_table "squads", force: :cascade do |t|
    t.string "name", null: false
    t.integer "points_total", default: 0, null: false
    t.integer "ranking_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "uk_squads_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "fifa_country_code", null: false
    t.string "name", null: false
    t.integer "group_order", null: false
    t.string "group_letter", null: false
    t.index ["fifa_country_code"], name: "index_teams_on_fifa_country_code", unique: true
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points_total"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "ranking_position", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "what3words", null: false
    t.string "name", null: false
    t.string "city", null: false
    t.string "timezone", null: false
    t.index ["name"], name: "index_venues_on_name", unique: true
    t.index ["what3words"], name: "index_venues_on_what3words", unique: true
  end

  add_foreign_key "matches", "teams", column: "left_team_id"
  add_foreign_key "matches", "teams", column: "right_team_id"
  add_foreign_key "matches", "venues"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
end
