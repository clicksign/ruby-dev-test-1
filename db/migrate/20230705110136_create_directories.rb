class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name
      t.string :ancestry

      t.timestamps
    end
    add_index :directories, :ancestry
  end
end
