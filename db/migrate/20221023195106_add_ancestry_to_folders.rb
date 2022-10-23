class AddAncestryToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :ancestry, :string
    add_index :folders, :ancestry
  end
end
