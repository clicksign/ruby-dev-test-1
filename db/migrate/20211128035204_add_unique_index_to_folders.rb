class AddUniqueIndexToFolders < ActiveRecord::Migration[6.1]
  def change
    add_index :folders, [:name, :parent_id], unique: true
  end
end
