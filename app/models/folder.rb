class Folder < ApplicationRecord
    belongs_to :parent, class_name: 'Folder', optional: true
    has_many :sub_folders, class_name: 'Folder', foreign_key: 'parent_id'
    has_many :document_files
end