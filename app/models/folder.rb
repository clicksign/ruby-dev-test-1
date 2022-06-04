class Folder < ApplicationRecord
  has_many_attached :files
  acts_as_nested_set
  validates :name, presence: true, uniqueness: { scope: :parent_id }

  scope :main, -> { where(parent_id: nil) }
end
