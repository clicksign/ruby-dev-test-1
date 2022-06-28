class AddAncestryToFolder < ActiveRecord::Migration[6.1]
  def change
    add_column :folders, :ancestry, :string
    add_index :folders, :ancestry
  end
end
