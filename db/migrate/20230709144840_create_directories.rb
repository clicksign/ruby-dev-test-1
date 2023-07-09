class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.bigint :parent_id, null: true

      t.string :name, limit: 255, null: false
      t.integer :subdirectories_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :directories, "parent_id, name", unique: true, name: "directories_parent_id_name_key"
    add_check_constraint :directories, "parent_id != id", name: "directories_parent_id_check"

    add_foreign_key :directories,
                    :directories,
                    column: :parent_id,
                    on_delete: :cascade,
                    name: "directories_parent_id_fkey"
  end
end
