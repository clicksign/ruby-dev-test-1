class CreateFolderFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :folder_files do |t|
      t.references :folder, null: true, foreign_key: true

      t.timestamps
    end
  end
end
