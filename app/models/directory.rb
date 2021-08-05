class Directory < ApplicationRecord
  has_ancestry
  validates :name, presence: true
  validates :ancestry, presence: true, if: -> {
    Directory.any?
  }
end