class LocalFile < FileSystem
	
	has_one :file_info,  foreign_key: "file_system_id"

	def path
		super
	end
end
