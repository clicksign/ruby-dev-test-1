class ChangeIndexDirectoryUniqScoped < ActiveRecord::Migration[7.0]
  def change
    add_index :directories, [:name, :parent_id, :user_id], unique: true
  end
end
