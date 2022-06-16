class Folder < ApplicationRecord
  belongs_to :folder, required: false
  has_many :childrens, class_name: 'Folder', primary_key: :id, foreign_key: :folder_id

  has_many_attached :files, dependent: :destroy

  validates :description, presence: true
end
