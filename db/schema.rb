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

ActiveRecord::Schema.define(version: 2021_03_10_060113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.string "marvel_uuid", null: false
    t.text "description"
    t.string "picture_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["marvel_uuid"], name: "index_characters_on_marvel_uuid", unique: true
    t.index ["name"], name: "index_characters_on_name", unique: true
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_rosters_on_character_id"
    t.index ["story_id", "character_id"], name: "index_rosters_on_story_id_and_character_id", unique: true
    t.index ["story_id"], name: "index_rosters_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.string "marvel_uuid"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["marvel_uuid"], name: "index_stories_on_marvel_uuid", unique: true
  end

  add_foreign_key "rosters", "characters"
  add_foreign_key "rosters", "stories"
end
