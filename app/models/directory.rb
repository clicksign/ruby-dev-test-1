class Directory < ApplicationRecord
  has_many :archives
  belongs_to :parent, class_name: 'Directory', foreign_key: 'parent_id', optional: true
  
  scope :root_path, -> { where(parent_id: nil).order(:title) }
  scope :childrens, ->(id) { where(parent_id: id).order(:title) }
end
