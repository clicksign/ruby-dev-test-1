class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.references :user, foreign_key: true
      t.references :parent, index: true, null: true
      t.text :name

      t.timestamps
    end
  end
end
