class FileDirectory < ApplicationRecord
  belongs_to :root_file_directory, class_name: "FileDirectory", optional: true
  belongs_to :main_file_directory, class_name: "FileDirectory", optional: true

  has_many_attached :files

  validates :path, presence: true, uniqueness: { scope: %i[root_file_directory_id main_file_directory_id] }
end
