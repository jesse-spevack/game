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

ActiveRecord::Schema[7.1].define(version: 2023_11_26_173804) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", null: false
    t.index ["level"], name: "index_players_on_level"
  end

  create_table "problems", force: :cascade do |t|
    t.string "operation"
    t.integer "x"
    t.integer "y"
    t.integer "solution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", null: false
    t.index ["level"], name: "index_problems_on_level"
    t.index ["x", "y", "operation"], name: "index_problems_on_x_and_y_and_operation", unique: true
  end

  create_table "responses", force: :cascade do |t|
    t.integer "value"
    t.boolean "correct"
    t.integer "started_at"
    t.integer "completed_at"
    t.bigint "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id", null: false
    t.index ["player_id"], name: "index_responses_on_player_id"
    t.index ["problem_id"], name: "index_responses_on_problem_id"
  end

  add_foreign_key "responses", "players"
  add_foreign_key "responses", "problems"
end
