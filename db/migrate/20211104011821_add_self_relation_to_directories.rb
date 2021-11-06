class AddSelfRelationToDirectories < ActiveRecord::Migration[6.1]
  def change
    add_reference :directories, :related_directory, foreign_key: { to_table: :directories }
  end
end
