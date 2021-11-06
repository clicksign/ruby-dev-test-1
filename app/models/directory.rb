class Directory < ApplicationRecord
  has_many :subdirectories, class_name: 'Directory', foreign_key: 'related_directory_id'
  belongs_to :super_directory, class_name: 'Directory', optional: true, foreign_key: 'related_directory_id'
  has_many_attached :files

  validates :name, presence: true
  validates :name, uniqueness: true
end
