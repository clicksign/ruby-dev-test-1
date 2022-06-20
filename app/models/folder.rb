class Folder < ApplicationRecord
  belongs_to :parent, :class_name => 'Folder'
  has_many :subfolders, :class_name => 'Folder', foreign_key: 'parent_id'

  scope :roots, -> { where(parent_id: nil) }

  def tree_data
    output = []
    Folder.roots.includes({
      subfolders: {subfolders: {
        subfolders: subfolders
      }}
    }).each do |emp|
      output << data(emp)
    end
    output.as_json
  end

  def data(folder)
    subfolders = []
    unless folder.subfolders.blank?
      folder.subfolders.each do |sub|
        subfolders << data(sub)
      end
    end
    {name: folder.name, subfolders: subfolders}
  end
end
