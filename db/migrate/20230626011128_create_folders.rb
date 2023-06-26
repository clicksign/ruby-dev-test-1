class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :ancestry, null: false
      t.references :file_system, null: false, foreign_key: true

      t.timestamps
    end

    add_index :folders, :ancestry
  end
end
