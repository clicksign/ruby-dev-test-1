class AddParentToDirectories < ActiveRecord::Migration[6.1]
  def change
    add_reference :directories, :parent, index: true, foreign_key: { to_table: :directories }
  end
end
