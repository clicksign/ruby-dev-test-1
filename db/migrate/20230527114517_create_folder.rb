class CreateFolder < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent_folder, foreign_key: { to_table: :folders }
      t.string :path

      t.timestamps
    end
  end
end
