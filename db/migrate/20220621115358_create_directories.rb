class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name, null: false, limit: 250
      t.text :full_path, index: { unique: true }, null: false

      t.references :parent_dir, foreign_key: { to_table: :directories }

      t.timestamps

      t.index %i[parent_dir_id name], unique: true
    end
  end
end
