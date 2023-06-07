class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.references :folder, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :archives, [:folder_id, :name], unique: true
  end
end
