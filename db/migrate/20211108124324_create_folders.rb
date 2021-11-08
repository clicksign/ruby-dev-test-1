class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string :title
      t.references :root, foreign_key: { to_table: :folders }

      t.timestamps
    end
  end
end
