class ChangeIndexArchiveUniqScoped < ActiveRecord::Migration[7.0]
  def change
    add_index :archives, [:name, :directory_id, :user_id], unique: true
  end
end
