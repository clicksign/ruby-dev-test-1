class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives, id: :uuid do |t|
      t.integer :status, null: false, default: 0
      t.string :file, null: false
      t.references :folder, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
