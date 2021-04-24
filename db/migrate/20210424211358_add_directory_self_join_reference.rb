class AddDirectorySelfJoinReference < ActiveRecord::Migration[6.1]
  def self.up
    add_reference :directories, :directory, index: true
  end

  def self.down
    remove_reference :directories, :directory, index: true
  end
end
