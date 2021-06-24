class Directory < ApplicationRecord
    has_many :archives
    has_many :subdirectorys, :class_name => "Directory", :foreign_key => 'directory_id'
end
