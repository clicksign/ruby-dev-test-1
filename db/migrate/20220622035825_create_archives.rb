class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :name, null: false, limit: 250
      t.text :full_path, index: { unique: true }, null: false

      t.references :directory, foreign_key: true

      t.timestamps

      t.index %i[directory_id name], unique: true
    end
  end
end
