class AddFolderAutoReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :folders, :folder, null: true, foreign_key: true
  end
end
