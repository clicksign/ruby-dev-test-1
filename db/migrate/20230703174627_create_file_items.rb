class CreateFileItems < ActiveRecord::Migration[7.0]
  def change
    create_table :file_items do |t|
      t.string :name
      t.integer :directory_id

      t.timestamps
    end
    add_index :file_items, :directory_id
  end
end
