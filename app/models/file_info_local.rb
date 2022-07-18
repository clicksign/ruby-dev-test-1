class FileInfoLocal < FileInfo

	attr_accessor :temp_path
	
	before_save do 
		storage_path = "#{Rails.root}/storage/" + File.dirname(self.path)
		unless File.directory?(storage_path)
		  FileUtils.mkdir_p(storage_path)
		end
		FileUtils.cp self.temp_path, storage_path
	end

	def path
		self.file_system.path
	end

	def download
		file = File.open(self.path, "rb")
		file.read
	end
end
