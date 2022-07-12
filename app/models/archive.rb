class Archive < ApplicationRecord
  validates :name, presence: true

  has_many_attached :files

  has_ancestry
end
