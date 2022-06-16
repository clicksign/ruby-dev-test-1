class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.references :folder, null: true, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
