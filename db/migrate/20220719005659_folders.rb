class Folders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :path
      t.references :parent_folder, index: true

      t.timestamps
    end
  end
end
