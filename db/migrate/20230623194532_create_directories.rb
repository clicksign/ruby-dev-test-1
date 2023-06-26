class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories, id: :uuid do |t|
      t.string :name, null: false
      t.references :parent, foreign_key: { to_table: :directories }, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :directories, [:name, :parent_id], unique: true
  end
end
