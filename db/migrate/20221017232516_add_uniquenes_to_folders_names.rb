class AddUniquenesToFoldersNames < ActiveRecord::Migration[7.0]
  def change
    add_index :folders, [:name, :parent_id], unique: true
  end
end
