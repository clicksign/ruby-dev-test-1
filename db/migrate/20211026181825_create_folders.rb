class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :folders }, index: true

      t.timestamps
    end
  end
end
