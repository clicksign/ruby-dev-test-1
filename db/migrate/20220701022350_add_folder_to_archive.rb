class AddFolderToArchive < ActiveRecord::Migration[7.0]
  def change
    add_reference :archives, :folder, index: true
  end
end
