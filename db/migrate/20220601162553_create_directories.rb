class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name

      t.timestamps
    end
    add_index :directories, [:name, :created_at]
  end
end
