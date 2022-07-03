class CreateTableDirectories < ActiveRecord::Migration[6.0]
  def change
    create_table :directories do |t|
      t.string  :name, null: false
      t.string  :path, null: false
      t.float   :size, null: false, default: 0.00
      t.references :parent, index: true, foreign_key: { to_table: 'directories' }, null: true

      t.timestamps
    end
  end
end
