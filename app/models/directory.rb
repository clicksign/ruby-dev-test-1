class Directory < ApplicationRecord

  include Pageable

  validates  :name, :created_by_id, presence: true
  
  belongs_to :created_by, class_name: 'User'
  has_many   :archives

  scope :subdirectories, -> (parent_id) { where(parent_id: parent_id) unless parent_id.blank? }
end