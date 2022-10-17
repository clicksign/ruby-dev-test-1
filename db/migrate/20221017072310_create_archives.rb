class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :name, null: false
      t.references :folder, null: true, foreign_key: true

      t.timestamps
    end
  end
end
