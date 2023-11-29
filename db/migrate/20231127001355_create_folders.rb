class CreateFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :folders }, null: true, index: true
      t.timestamps
    end

    add_index :folders, [:name, :parent_id], unique: true
  end
end
