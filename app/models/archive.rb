class Archive < ApplicationRecord

  include Pageable

  validates  :filename, :created_by_id, :directory_id, presence: true
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :directory

  mount_base64_uploader :file, ArchivesUploader
end
