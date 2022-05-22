class CreateAppFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :app_folders do |t|
      t.string :folder_name

      t.timestamps
    end
  end
end
