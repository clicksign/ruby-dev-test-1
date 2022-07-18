class FileInfo < ApplicationRecord
	belongs_to :file_system

	validates :file_system, presence: true

	attr_accessor :temp_path

end
