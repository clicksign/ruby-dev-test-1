class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.integer :parent_id, null: true
      t.string :document

      t.timestamps
    end
  end
end
