class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.integer :parent_id, null: true, index: true

      t.timestamps
    end

    add_index :folders, [:parent_id, :name], unique: true
  end
end
