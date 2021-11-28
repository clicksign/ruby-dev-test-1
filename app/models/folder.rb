class Folder < ApplicationRecord
  has_many_attached :documents
  has_many :children, class_name: "Folder",
                          foreign_key: "parent_id",
                          dependent: :destroy
  belongs_to :parent, class_name: "Folder", optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }
  validate :document_uniquiness
  
  before_destroy :ensure_is_not_root, prepend: true do
    throw(:abort) if errors.present?
  end

  before_create :ensure_document_name_is_unique, prepend: true do
    throw(:abort) if errors.present?
  end

  scope :root , -> { first_or_create(name: "/", parent_id: nil).children }
  scope :child_folders , ->(folder_id) { where(parent_id: folder_id) }
  
  private

  def ensure_is_not_root
    errors.add(:base, 'Root folder cannot be removed!') if self.parent_id.nil?
  end

  def ensure_uniqueness_of_root
    errors.add(:base, 'There is only one root folder!') if Folder.where(parent_id: nil).size > 0
  end

  def document_uniquiness
    array_of_filenames = self.documents.map{|doc| doc.blob.filename.to_s }
    errors.add(:documents, 'Document already exists!') if array_of_filenames.uniq.length != array_of_filenames.length
  end

end