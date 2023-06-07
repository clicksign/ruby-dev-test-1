class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent, null: true, index: true, foreign_key: { to_table: :folders }

      t.timestamps
    end
  end
end
