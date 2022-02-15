class Folder < ApplicationRecord
  has_many :subfolders, class_name: 'Folder'
  belogs_to :ref
end
