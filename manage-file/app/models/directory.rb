class Directory < ApplicationRecord
  validates :name, presence: true, allow_blank: false
	
	has_many :subdir, :class_name => "Directory", foreign_key: 'parent_id'
	
	belongs_to :parent, :class_name => "Directory", foreign_key: 'parent_id', :optional => true
	
	has_many :the_files, foreign_key: 'directory_id', :dependent => :delete_all
	
	def tree
    { 
			"directory" => self.name,
			"files"     => self.the_files.map { |f|
				f.name
			},
      "subdir"    => self.subdir.map { |s| 
				s.tree
			}
    }
  end
	
end
