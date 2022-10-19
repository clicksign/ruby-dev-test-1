class AddSizeFielsToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :byte_size, :bigint, default: 0, null: false
    add_column :folders, :trusted_sized, :boolean, null: false, default: true
  end
end
