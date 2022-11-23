class CreateDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :directories do |t|
      t.integer :parent_id, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
