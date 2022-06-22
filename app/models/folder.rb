class Folder < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :folder, optional: true
  has_many :subfolders, class_name: 'Folder', dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :name, uniqueness: { scope: :folder }, if: -> { name_changed? || folder_id_changed? }
  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_with FolderIdValidator, if: -> { folder_id_changed? }

  before_save :set_path_ids, if: -> { folder_id_changed? }

  private

  def set_path_ids
    self.path_ids = [] unless folder

    self.path_ids = folder.path_ids + [folder.id]
  end
end
