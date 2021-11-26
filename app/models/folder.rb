class Folder < ApplicationRecord
  belongs_to :parent_folder, optional: true, class_name: 'Folder'

  has_many :subfolders, 
    dependent: :destroy,
    class_name: 'Folder',
    foreign_key: 'parent_folder_id'
  
  validates :name, presence: true

end
