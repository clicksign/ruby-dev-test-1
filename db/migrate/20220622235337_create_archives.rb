class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :name
      t.integer :size, default: 0
      t.belongs_to :folder, foreign_key: true

      t.timestamps
    end

    add_index :archives, 'name, COALESCE(folder_id, 0)', unique: true
  end
end
