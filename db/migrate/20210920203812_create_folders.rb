class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :title
      t.references :parent
      t.timestamps
    end
  end
end
