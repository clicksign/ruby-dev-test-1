class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :path_ids, default: [], array: true
      t.integer :size, default: 0
      t.belongs_to :folder, foreign_key: true

      t.timestamps
    end

    add_index :folders, 'name, COALESCE(folder_id, 0)', unique: true
  end
end
