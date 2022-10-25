class LocalFile < ApplicationRecord
  has_many :media, as: :fileable

  validates :name, presence: true
end
