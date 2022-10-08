class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent_folder, index: true, foreign_key: {to_table: :folders}

      t.timestamps
    end
  end
end
