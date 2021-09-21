class AddContentToDocumentFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :document_files, :content, :string
  end
end
