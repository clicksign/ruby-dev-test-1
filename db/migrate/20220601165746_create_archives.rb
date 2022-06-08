class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :name
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
    add_index :archives, [:directory_id, :created_at]
  end
end
