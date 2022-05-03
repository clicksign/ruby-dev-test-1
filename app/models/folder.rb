class Folder < ApplicationRecord
  has_many :directories
  has_many :sub_folders, through: :directories
end
