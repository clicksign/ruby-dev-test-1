class CreateDirectoryFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :directory_files do |t|
      t.belongs_to :directory, foreign_key:true
      t.string :name
      t.string :path
      t.float :size

      t.timestamps
    end
  end
end
