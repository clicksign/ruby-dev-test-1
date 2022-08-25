class CreateFileSystemItems < ActiveRecord::Migration[5.2]
  def change
    create_table :file_system_items do |t|
      t.string :name, null: false
      t.integer :kind, null: false
      t.string :ancestry
      t.timestamps
    end
  end
end
