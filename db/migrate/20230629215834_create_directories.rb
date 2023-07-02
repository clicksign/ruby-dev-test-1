class CreateDirectories < ActiveRecord::Migration[7.0]
  def up
    create_table :directories, id: :uuid do |t|
      t.string     :name, null: false, index: true
      t.references :parent, foreign_key: { to_table: :directories}, type: :uuid
      t.references :created_by, index: true, foreign_key: { to_table: :users}, null: false, type: :uuid    
      t.timestamps null: false
    end
  end

  def down
    drop_table :directories
  end
end
