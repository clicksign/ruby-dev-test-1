class Folder < ApplicationRecord
  belongs_to :parent, class_name: :Folder, foreign_key: :folder_id, optional: true
  has_many   :subfolders, class_name: :Folder

  validates :name,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { scope: :folder_id, case_sensitive: true }
end
