# frozen_string_literal: true

# Error Class
class FolderError < StandardError; end

class Folder < ApplicationRecord
  belongs_to :parent_folder, class_name: 'Folder', optional: true
  has_many :sub_folders, class_name: 'Folder', foreign_key: :parent_folder_id, dependent: :destroy

  has_many :files, class_name: 'Storage'

  validates :name, presence: true, uniqueness: { scope: :parent_folder_id }

  before_save :set_path

  scope :tree, -> (folder) { where('path LIKE ?', "#{folder&.path}%").order(:path) }

  def move_to(folder)
    sub_folders = Folder.where('path LIKE ?', "#{self.path}/%")
    raise FolderError, 'Cyclic operation' if sub_folders.include?(folder)
    self.parent_folder = folder
    save!
    update_paths(sub_folders)
  end
  
  private
  
  def set_path
    self.path = parent_folder ? "#{self.parent_folder.path}/#{name}" : name
  end
  
  def update_paths(sub_folders = self.sub_folders)
    sub_folders.each do |sub_folder|
      sub_folder.save!
      sub_folder.send(:update_paths)
    end   
  end
end
