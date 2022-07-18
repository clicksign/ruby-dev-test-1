class CreateFileBlobs < ActiveRecord::Migration[7.0]
  def change
    create_table :file_blobs do |t|
      t.integer :file_info_id, null: false
      t.binary :file_content, null: false
      t.timestamps
    end
    add_index :file_blobs, :file_info_id
  end
end
