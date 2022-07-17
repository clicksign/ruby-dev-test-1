class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories do |t|
      t.string :name
      # null means it is a root directory
      t.belongs_to(:parent, null: true, foreign_key: true, foreign_key: {
                     to_table: :directories })

      t.timestamps
    end
  end
end
