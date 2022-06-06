class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.references :folder, foreign_key: true
      t.string :name

      t.timestamps
      t.index [:folder_id, :name], unique: true
    end
  end
end
