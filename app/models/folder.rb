class Folder < ApplicationRecord
  has_many :subfolders, class_name: 'Folder', foreign_key: 'ref_id'
  belogs_to :ref, class_name: 'Folder', optional: true
end
