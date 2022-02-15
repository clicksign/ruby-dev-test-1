class Folder < ApplicationRecord
  has_many :subfolders, class_name: 'Folder'
end
