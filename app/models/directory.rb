class Directory < ApplicationRecord
    has_many :archives
    has_many :subdirectories, :class_name => "Directory", :foreign_key => 'directory_id'
    belongs_to :atop_directory, :class_name => "Directory", :foreign_key => 'directory_id'
end
