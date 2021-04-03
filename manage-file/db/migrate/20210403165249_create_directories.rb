class CreateDirectories < ActiveRecord::Migration[5.2]
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :parent

      t.timestamps
    end
  end
end
