class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders, id: :uuid do |t|
      t.string :name, null: false
      t.references :parent_folder, foreign_key: { to_table: :folders }, type: :uuid

      t.timestamps
    end
  end
end
