class Archive < ApplicationRecord
  has_one_attached :file

  validates :name, :file, presence: :true
end
