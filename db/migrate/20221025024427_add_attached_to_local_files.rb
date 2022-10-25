class AddAttachedToLocalFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :local_files, :attached, :string
  end
end
