class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :folder, null: false

      t.timestamps
    end

    add_index :documents, %i[name folder_id], unique: true
  end
end
