class Folder < ApplicationRecord
    belongs_to :document, class_name: 'Document', optional: true
    belongs_to :main_folder, class_name: 'Folder', optional: true
    has_many :subfolders, class_name: 'Folder', foreign_key: 'main_folder_id'

    validates :name, presence: true
end
