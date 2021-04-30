class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.binary :content, limit: 10.megabyte
      t.references :folder, foreign_key: { to_table: 'folders' }

      t.timestamps
    end
  end
end
