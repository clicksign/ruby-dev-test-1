class FileInfoS3 < FileInfo

	has_one_attached :file

	before_save do
    	self.file.attach(io: File.open(self.temp_path), filename: File.basename(self.temp_path))
  	end

  	def download
  		self.file.download
  	end
end
