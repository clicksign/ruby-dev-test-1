class Directory < ApplicationRecord
  belongs_to :parent, optional: true, class_name: 'Directory'

  has_many :subdirectories,
           dependent: :destroy,
           class_name: 'Directory',
           foreign_key: 'parent_id'

  validates :name, presence: true

  has_many_attached :files
end
