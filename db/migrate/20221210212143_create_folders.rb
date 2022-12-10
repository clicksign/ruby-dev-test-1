class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :folders }, index: true
      t.index [:name, :parent_id], unique: true

      t.timestamps
    end
  end
end
