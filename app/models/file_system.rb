# Top-level class that represents a file system
# May be associated with a user/organization in the future
class FileSystem < ApplicationRecord
  has_many :folders, dependent: :destroy
  has_many :documents, dependent: :destroy
end
