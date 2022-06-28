class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :folder, null: true, foreign_key: true, index:true

      t.timestamps
    end
  end
end
