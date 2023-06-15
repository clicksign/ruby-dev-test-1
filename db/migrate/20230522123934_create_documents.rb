class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :name, null: false
      t.references :directory, null: false, type: :uuid

      t.timestamps
    end
  end
end
