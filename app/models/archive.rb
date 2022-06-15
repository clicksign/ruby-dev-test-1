class Archive < ApplicationRecord
  belongs_to :directory
  has_many_attached :datas

  validates :name, presence: true
end
