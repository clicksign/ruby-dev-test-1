class CreateUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :uploads do |t|
      t.references :folder, null: false, foreign_key: true
      t.timestamps
    end
  end
end
