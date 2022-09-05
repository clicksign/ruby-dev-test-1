class AddFolderRefToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_reference :documents, :folder, foreign_key: true, after: :description
  end
end
