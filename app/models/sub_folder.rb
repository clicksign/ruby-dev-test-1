class SubFolder < ApplicationRecord
  has_many :directories
  has_many :folders, through: :directories
end
