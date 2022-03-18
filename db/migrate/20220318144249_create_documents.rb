class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :folder, null: true, foreign_key: true
      t.integer :origin

      t.timestamps
    end
  end
end
