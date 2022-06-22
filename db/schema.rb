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

ActiveRecord::Schema[7.0].define(version: 2022_06_22_203446) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "path_ids", default: [], array: true
    t.integer "size", default: 0
    t.bigint "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "name, COALESCE(folder_id, (0)::bigint)", name: "index_folders_on_name_COALESCE_folder_id_0", unique: true
    t.index ["folder_id"], name: "index_folders_on_folder_id"
  end

  add_foreign_key "folders", "folders"
end
