class RenameForeignKeyForArchives < ActiveRecord::Migration[7.0]
  def change
    change_table(:archives) do |t|
      t.rename :directory_id, :parent_id
    end
  end
end
