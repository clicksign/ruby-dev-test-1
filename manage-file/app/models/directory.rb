class Directory < ApplicationRecord
  validates :name, presence: true, allow_blank: false
	has_many :subdir, :class_name => "Directory", foreign_key: 'parent_id'
	belongs_to :parent, :class_name => "Directory", foreign_key: 'parent_id', :optional => true
	has_many :the_files, foreign_key: 'directory_id', :dependent => :delete_all
end
