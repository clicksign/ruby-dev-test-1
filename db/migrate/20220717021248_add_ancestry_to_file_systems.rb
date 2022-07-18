class AddAncestryToFileSystems < ActiveRecord::Migration[7.0]
  def change
    add_column :file_systems, :ancestry, :string
    add_index :file_systems, :ancestry
  end
end
