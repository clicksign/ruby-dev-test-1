class DocumentFile < ApplicationRecord
    belongs_to :folder
    has_one_attached :file
end
