class FileBlob < ApplicationRecord
	belongs_to :file_info

	validates :file_info, presence: true
end
