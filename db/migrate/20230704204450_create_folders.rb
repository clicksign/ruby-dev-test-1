class CreateFolders < ActiveRecord::Migration[7.0]
  # Separação em up/down somente para exemplo
  def up
    create_table :folders, id: :uuid do |t|
      t.string :name, null: false, limit: 300
      t.references :main_folder, null: true,
                                 foreign_key: { to_table: :folders },
                                 index: true,
                                 type: :uuid

      t.timestamps
    end

    add_index :folders, :name, unique: true
  end

  def down
    drop_table :folders
  end
end
