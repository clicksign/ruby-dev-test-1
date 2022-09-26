class DirectoryFile < ApplicationRecord
  belongs_to :directory
  has_one_attached :file_content
end
