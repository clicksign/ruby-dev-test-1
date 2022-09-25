class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|  
      t.references :parent_directory, foreign_key: { to_table: :directories }
      t.string :name
      t.string :path
      t.float :size

      t.timestamps
    end
  end
end
