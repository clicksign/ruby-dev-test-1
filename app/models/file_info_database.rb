class FileInfoDatabase < FileInfo
	attr_accessor :temp_path

	has_one :file_blob,  foreign_key: "file_info_id"

	after_save do 
		file = File.open(self.temp_path).read
		self.create_file_blob(file_content: file)
	end

	def download
		self.file_blob.file_content
	end
end
