class CreateFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :files do |t|
      t.string :name
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
