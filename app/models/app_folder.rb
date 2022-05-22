class AppFolder < ApplicationRecord
  has_many :children, class_name: 'AppFolder', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'AppFolder', foreign_key: 'parent_id', optional: true

  validates :folder_name, presence: true
end
