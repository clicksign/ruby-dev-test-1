class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.belongs_to :directory, null: false

      t.timestamps
    end
  end
end
