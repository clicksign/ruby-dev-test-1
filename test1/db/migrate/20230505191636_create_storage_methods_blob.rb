class CreateStorageMethodsBlob < ActiveRecord::Migration[7.0]
  def change
    create_table :storage_methods_blobs do |t|
      t.binary :content, null: false

      t.timestamps
    end
  end
end
