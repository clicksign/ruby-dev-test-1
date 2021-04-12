class Directory < ApplicationRecord
  has_ancestry

  validates :name, presence: true, uniqueness: { scope: :ancestry }
end
