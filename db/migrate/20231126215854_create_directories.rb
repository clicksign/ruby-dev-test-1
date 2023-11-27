class CreateDirectories < ActiveRecord::Migration[7.1]
  def change
    create_table :directories do |t|
      t.string :name
      t.references :parent_directory, null: true, foreign_key: { to_table: :directories }

      t.timestamps
    end
  end
end
