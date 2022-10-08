class CreateArquives < ActiveRecord::Migration[6.1]
  def change
    create_table :arquives do |t|
      t.string :name
      t.integer :persistence, null: false
      t.string :path
      t.binary :data
      t.references :directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
