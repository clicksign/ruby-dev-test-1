class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :parent_id, null: true, index: true
      
      t.timestamps
    end
    add_foreign_key :folders, :folders, column: :parent_id
  end
end
