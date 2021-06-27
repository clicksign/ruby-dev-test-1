class CreateSubdirectories < ActiveRecord::Migration[6.0]
  def change
    create_table :subdirectories do |t|
      t.string :name
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
