class Folder < ApplicationRecord
  belongs_to :parent, :class_name => 'Folder', optional: true
  has_many :subfolders, :class_name => 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy

  scope :main_root, -> { where(parent_folder_id: nil) }
  
  def folder_structure
   structure = []

   self.subfolders.map{ |s| structure << s.name } if self.subfolders.present?
    
   return structure
  end

  def print_work_directory
    if self.parent_folder_id.present?
      first_path = Folder.find(self.parent_folder_id).name
      
      return '/' +  first_path + '/' + self.name
    end

    return '/' + self.name
  end

  def list_folder_files
   FileAttachment.where(folder_id: id).pluck(:name)
  end
end
