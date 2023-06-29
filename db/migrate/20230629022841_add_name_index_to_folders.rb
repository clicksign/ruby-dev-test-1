class AddNameIndexToFolders < ActiveRecord::Migration[7.0]
  def change
    add_index :folders, [:name, :file_system_id, :ancestry], unique: true
  end
end
