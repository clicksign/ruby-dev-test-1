class FileSystem < ApplicationRecord
	has_ancestry
	
	validates :name, presence: true

	def path
		return self.ancestors.map{|a| "/" +  a.name}.join("") + "/" + self.name
	end

end
