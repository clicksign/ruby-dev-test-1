class AddIndexTonFolderLabelScoped < ActiveRecord::Migration[7.0]
  def change
    add_index :folders, :label, unique: true, where: 'ancestry IS NULL'
    add_index :folders, [:label, :ancestry], unique: true
  end
end
