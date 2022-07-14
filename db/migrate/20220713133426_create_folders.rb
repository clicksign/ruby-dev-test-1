class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :path
      t.references :parent, index: true

      t.timestamps
    end
  end
end
