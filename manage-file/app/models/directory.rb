class Directory < ApplicationRecord
    has_many :children, :class_name => "Directory", foreign_key: 'parent'
    belongs_to :parent, :class_name => "Directory", foreign_key: 'parent', :optional => true
end
