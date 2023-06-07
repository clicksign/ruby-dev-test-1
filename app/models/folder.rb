class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :parent

  validates :name, presence: true
end
