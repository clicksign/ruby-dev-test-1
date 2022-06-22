class RenameForeignKeyForDirectories < ActiveRecord::Migration[7.0]
  def change
    change_table(:directories) do |t|
      t.rename :parent_dir_id, :parent_id
    end
  end
end
