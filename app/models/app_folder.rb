class AppFolder < ApplicationRecord
  has_many :children, class_name: 'AppFolder', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'AppFolder', foreign_key: 'parent_id', optional: true

  validates :folder_name, presence: true

  scope :root_folders, -> { where(parent_id: nil) }

  def root_folder
    return self unless parent.present?

    parent.root_folder
  end
end
