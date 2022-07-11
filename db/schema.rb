ActiveRecord::Schema[7.0].define(version: 2022_07_10_214049) do
  create_table "arquivos", force: :cascade do |t|
    t.boolean "pasta", default: true
    t.string "nome"
    t.string "caminho"
    t.integer "diretorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diretorio_id"], name: "index_arquivos_on_diretorio_id"
  end

  add_foreign_key "arquivos", "arquivos", column: "diretorio_id"
end
