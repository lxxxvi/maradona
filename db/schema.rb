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

ActiveRecord::Schema.define(version: 20180114123629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "venue_id"
    t.integer "left_team_id", null: false
    t.integer "right_team_id", null: false
    t.string "phase", null: false
    t.integer "left_team_score"
    t.integer "right_team_score"
    t.time "kickoff_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phase", "left_team_id", "right_team_id"], name: "index_matches_on_phase_and_left_team_id_and_right_team_id", unique: true
    t.index ["venue_id"], name: "index_matches_on_venue_id"
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
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id", "match_id"], name: "index_predictions_on_user_id_and_match_id"
    t.index ["user_id"], name: "index_predictions_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "group_id"
    t.string "fifa_country_code", null: false
    t.string "name", null: false
    t.integer "group_order", null: false
    t.index ["fifa_country_code"], name: "index_teams_on_fifa_country_code", unique: true
    t.index ["group_id"], name: "index_teams_on_group_id"
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
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
  add_foreign_key "teams", "groups"
end
