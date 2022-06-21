class CreateFileResources < ActiveRecord::Migration[7.0]
  def change
    create_table :file_resources do |t|
      t.string :name
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
