class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.references :directory, null: false

      t.timestamps
    end
  end
end
