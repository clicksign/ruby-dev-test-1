class ChangeIndexDirectoryUniqScoped < ActiveRecord::Migration[7.0]
  def change
    add_index :directories, %i[name parent_id user_id], unique: true
  end
end
