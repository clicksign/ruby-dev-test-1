class AddFileToArchives < ActiveRecord::Migration[6.0]
  def change
    add_column :archives, :file, :string
  end
end
