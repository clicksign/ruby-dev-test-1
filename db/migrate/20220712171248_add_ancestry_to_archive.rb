class AddAncestryToArchive < ActiveRecord::Migration[6.0]
  def change
    add_column :archives, :ancestry, :string
    add_index :archives, :ancestry
  end
end
