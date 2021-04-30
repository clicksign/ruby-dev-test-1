class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.references :main_folder, foreign_key: { to_table: 'folders' }

      t.timestamps
    end
  end
end
