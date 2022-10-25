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

ActiveRecord::Schema[7.0].define(version: 2022_10_25_024427) do
  create_table "folders", force: :cascade do |t|
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_folders_on_ancestry"
    t.index ["label", "ancestry"], name: "index_folders_on_label_and_ancestry", unique: true
    t.index ["label"], name: "index_folders_on_label", unique: true, where: "ancestry IS NULL"
  end

  create_table "local_files", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attached"
  end

  create_table "media", force: :cascade do |t|
    t.integer "folder_id", null: false
    t.string "fileable_type", null: false
    t.integer "fileable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fileable_type", "fileable_id"], name: "index_media_on_fileable"
    t.index ["folder_id"], name: "index_media_on_folder_id"
  end

  add_foreign_key "media", "folders"
end
