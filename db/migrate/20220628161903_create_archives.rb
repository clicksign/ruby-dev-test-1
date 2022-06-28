class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.string :name
      t.references :folder, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
