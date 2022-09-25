class Directory < ApplicationRecord
  has_many :sub_directories, class_name: "Directory",
  foreign_key: "parent_directory_id"
  
  belongs_to :parent_directory, class_name: "Directory", optional: true
  
  has_many :directory_files, class_name: "DirectoryFile",
                             foreign_key: "directory_id"
end
