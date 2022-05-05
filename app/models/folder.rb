class Folder < ApplicationRecord
  has_many :directories
  has_many :sub_folders, through: :directories
  has_many_attached :documents
end
