class Document < ApplicationRecord
    has_one :folder, class_name: 'Folder'

    validates :name, presence: true
    validates :content, presence: true
end
