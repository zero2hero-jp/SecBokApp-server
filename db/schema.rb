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

ActiveRecord::Schema[7.0].define(version: 2022_10_17_102820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "knowledges", force: :cascade do |t|
    t.integer "sheet_id"
    t.string "role"
    t.decimal "score", precision: 7, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sheets", force: :cascade do |t|
    t.string "email"
    t.string "spreadsheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "years", force: :cascade do |t|
    t.integer "sheet_id"
    t.string "title"
    t.integer "l"
    t.integer "m"
    t.integer "h"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
