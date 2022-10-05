class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :title
      t.binary :value
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
