class Archive < ApplicationRecord
  has_many_attached :files

  belongs_to :directory

  validates_presence_of :name
end