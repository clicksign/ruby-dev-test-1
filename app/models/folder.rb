class Folder < ApplicationRecord
  has_many_attached :documents

  has_many :children, class_name: "Folder",
                          foreign_key: "parent_id",
                          dependent: :destroy

  belongs_to :parent, class_name: "Folder", optional: true

  validates :name, presence: true
  before_destroy :ensure_is_not_root, prepend: true do
    throw(:abort) if errors.present?
  end

  scope :root , -> { where(parent_id: nil) }
  scope :children , ->(folder_id) { where(parent_id: folder_id) }
  
  private

  def ensure_is_not_root
    errors.add(:base, "Root folder cannot be removed!") if self.parent_id.nil?
  end

end