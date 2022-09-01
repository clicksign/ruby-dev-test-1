class CreateFileDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :file_directories do |t|
      t.references :root_file_directory, foreign_key: { to_table: :file_directories }
      t.references :main_file_directory, foreign_key: { to_table: :file_directories }
      t.string :path, null: false
      t.timestamps
    end

    add_index :file_directories, %i[path root_file_directory_id main_file_directory_id],
              name: "idx_unique_path",
              unique: true
  end
end
