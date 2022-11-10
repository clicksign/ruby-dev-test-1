class RenameFilesToDocuments < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :files, :documents
  end

  def self.down
    rename_table :documents, :files
  end
end
