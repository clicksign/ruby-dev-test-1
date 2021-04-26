class AddDirectoryReferenceToArchive < ActiveRecord::Migration[6.1]
  def self.up
    add_reference :archives, :directory, index: true
  end

  def self.down
    remove_reference :archives, :directory, index: true
  end
end
