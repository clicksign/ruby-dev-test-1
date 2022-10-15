class AddParentToFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :folders, null: true, foreign_key: true
  end
end
