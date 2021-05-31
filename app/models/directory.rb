class Directory < ApplicationRecord
  has_ancestry
  has_many_attached :files

  validates :name, presence: true, uniqueness: { scope: :ancestry }
end
