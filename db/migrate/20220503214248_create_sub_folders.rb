class CreateSubFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_folders do |t|
      t.string :name

      t.timestamps
    end
  end
end
