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

ActiveRecord::Schema[7.0].define(version: 2022_12_09_183709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "archives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "filename"
    t.uuid "directory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["directory_id"], name: "index_archives_on_directory_id"
  end

  create_table "directories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "dirname", null: false
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dirname", "parent_id"], name: "index_directories_on_dirname_and_parent_id", unique: true
    t.index ["parent_id"], name: "index_directories_on_parent_id"
  end

  add_foreign_key "archives", "directories"
  add_foreign_key "directories", "directories", column: "parent_id"
end
