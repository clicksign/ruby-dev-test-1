class AppFolder < ApplicationRecord
  has_many :children, class_name: 'AppFolder', foreign_key: 'parent_id'
  has_many :app_files
  belongs_to :parent, class_name: 'AppFolder', foreign_key: 'parent_id', optional: true

  validates :folder_name, presence: true

  scope :root_folders, -> { where(parent_id: nil) }

  before_destroy :remove_children

  def root_folder
    return self unless parent.present?

    parent.root_folder
  end

  def parents
    return [self.id] unless parent.present?

    parent.parents + [self.id]
  end

  def remove_children
    children.destroy_all
    app_files.destroy_all
  end
end
