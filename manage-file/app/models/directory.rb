class Directory < ApplicationRecord
    has_many :children, :class_name => "Directory", foreign_key: 'parent_id'
    belongs_to :parent, :class_name => "Directory", foreign_key: 'parent_id', :optional => true
end_id
