class AddSelfJoinToDirectories < ActiveRecord::Migration[5.2]
  def change
    add_reference :directories, :ref_directory, foreign_key: { to_table: :directories }
  end
end
