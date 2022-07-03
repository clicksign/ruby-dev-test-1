class CreateTableDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string      :name, null: false
      t.string      :path, null: false
      t.string      :ext, null: false
      t.float       :size, null: false
      t.references :directory, index: true, foreign_key: { to_table: 'directories' }, null: false

      t.timestamps
    end
  end
end
