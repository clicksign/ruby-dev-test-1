class Folder < ApplicationRecord
  belongs_to :parent, class_name: :Folder, foreign_key: :folder_id, optional: true
  has_many   :subfolders, -> { order(name: :asc) }, class_name: :Folder
  has_many   :documents, -> { order(name: :asc) }

  validates :name,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { scope: :folder_id, case_sensitive: false }

  def items
    subfolders + documents
  end
end
