class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :parent_id, null: true

      t.timestamps
    end
    add_index :folders, :parent_id
  end
end
