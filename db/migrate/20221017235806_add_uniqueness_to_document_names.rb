class AddUniquenessToDocumentNames < ActiveRecord::Migration[7.0]
  def change
    add_index :documents, [:name, :folder_id], unique: true
  end
end
