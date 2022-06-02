class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
