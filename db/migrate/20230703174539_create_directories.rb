class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_index :directories, :parent_id
  end
end
