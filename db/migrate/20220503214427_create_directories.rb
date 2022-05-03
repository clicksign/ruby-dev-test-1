class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.references :folder, null: false, foreign_key: true
      t.references :sub_folder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
