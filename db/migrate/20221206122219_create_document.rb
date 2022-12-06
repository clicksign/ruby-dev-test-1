class CreateDocument < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :directory, foreign_key: true, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
