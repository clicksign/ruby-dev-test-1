class CreateStorage < ActiveRecord::Migration[7.0]
  def change
    create_table :storages do |t|
      t.string :name
      t.references :folder, foreign_key: true
      t.string :type
      t.binary :file_data
      t.timestamps
    end
  end
end
