class FileAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :file_attachments do |t|
      t.string :name
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
