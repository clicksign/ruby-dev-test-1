class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :folder, null: true
      t.references :file_system, null: false, foreign_key: true

      t.timestamps
    end
  end
end
