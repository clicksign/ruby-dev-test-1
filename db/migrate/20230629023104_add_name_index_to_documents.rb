class AddNameIndexToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_index :documents, [:name, :file_system_id, :folder_id], unique: true
  end
end
