class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.references :parent, null: true, foreign_key: { to_table: :folders }

      t.timestamps
    end
  end
end
