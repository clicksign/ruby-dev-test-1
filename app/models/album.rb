class Album < ApplicationRecord
  belongs_to :player
  has_and_belongs_to_many :players

  validates :name, presence: true

  has_one_attached :image
  validates :image, presence: true
end
