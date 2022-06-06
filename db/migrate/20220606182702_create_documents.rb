class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :folder, foreign_key: true
      t.string :name, null: false

      t.timestamps
      t.index [:folder_id, :name], unique: true
    end
  end
end
