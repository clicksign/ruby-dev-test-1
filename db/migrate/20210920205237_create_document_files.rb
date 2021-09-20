class CreateDocumentFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :document_files do |t|
      t.string :title
      t.references :folder, null: false, foreign_key: true
      t.timestamps
    end
  end
end
