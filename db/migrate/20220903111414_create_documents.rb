class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.text :title,       null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
