class AddParentReferencesToAppFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :app_folders, :parent, index: true
  end
end
