class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.references :folder, foreign_key: true, null: false
      t.timestamps
    end

    add_index :documents, :name, unique: true
  end
end
