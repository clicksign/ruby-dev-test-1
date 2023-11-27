class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :storage_type
      t.string :name
      t.references :directory, null: false, foreign_key: true
      t.binary :content

      t.timestamps
    end
  end
end
