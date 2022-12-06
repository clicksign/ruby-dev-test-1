class CreateDirectory < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.references :directory, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
