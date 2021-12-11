class CreateDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :directories do |t|
      t.string :name, null: false
      t.references :parent, foreign_key: { to_table: :directories }

      t.timestamps
    end
  end

  def down
    drop_table :directories
  end
end
