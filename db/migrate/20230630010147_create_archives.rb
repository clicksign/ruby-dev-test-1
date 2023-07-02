class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives, id: :uuid do |t|
      t.string     :name, null: false, index: true
      t.string     :file
      t.string     :filename, null: false
      t.references :directory, null: false, index: true, type: :uuid
      t.references :created_by, index: true, foreign_key: { to_table: :users}, null: false, type: :uuid
      t.string     :url

      t.timestamps null: false
    end
  end

  def down
    drop_table :archives
  end
end
