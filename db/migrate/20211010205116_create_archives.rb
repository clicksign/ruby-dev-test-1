class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.binary :file
      t.string :mime_type
      t.string :name
      t.references :sub_directory, null: true, foreign_key: true

      t.timestamps
    end
  end
end
