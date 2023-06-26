class ChangeIndexArchiveUniqScoped < ActiveRecord::Migration[7.0]
  def change
    add_index :archives, %i[name directory_id user_id], unique: true
  end
end
