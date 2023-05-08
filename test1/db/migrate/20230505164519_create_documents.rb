class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :storage_method, null: false
      t.string :key, null: false
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end

    add_index :documents, [:folder_id, :name],
      unique: true,
      name: "folder_name_idx"
  end
end
