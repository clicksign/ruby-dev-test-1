class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :sub_directories, dependent: :destroy, class_name: 'Directory', foreign_key: 'parent_id'

  has_many_attached :files

  validates_uniqueness_of :name, scope: :parent_id
end
