class CreateTheFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :the_files do |t|
      t.string :name
      t.text :blob
      t.references :directory, foreign_key: true

      t.timestamps
    end
  end
end
