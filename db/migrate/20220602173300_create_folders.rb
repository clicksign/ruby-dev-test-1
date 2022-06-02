class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false, unique: true
      t.references :parent, foreign_key: { to_table: :folders }, null: true
      t.timestamps
    end
  end
end
