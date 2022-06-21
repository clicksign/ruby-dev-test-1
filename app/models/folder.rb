class Folder < ApplicationRecord
  belongs_to :parent, :class_name => 'Folder', optional: true
  has_many :subfolders, :class_name => 'Folder', foreign_key: 'parent_id', dependent: :destroy
  has_many :file_resources, dependent: :destroy

  scope :roots, -> { where(parent_id: nil) }

  validates :name, {
    presence: true,
    uniqueness: {scope: :parent_id, case_sensitive: false}
  }

  def breadcrumbs
    path = []
    p = Proc.new do |parent|
      path.push(parent.name)
      p.call(parent.parent) if parent.parent.present?
    end
    p.call(self)
    path.reverse.join('/')
  end

  def tree_data
    structure = {}
    Folder.roots.each do |root|
      structure.merge! build_tree_data(root)
    end
    structure
  end

  def below_nodes
    build_tree_data(self)
  end

  def build_tree_data(folder)
    subfolders = []

    if folder.subfolders.present?
      folder.subfolders.each do |sub|
        subfolders << build_tree_data(sub)
      end
    end

    {
      name: folder.name,
      subfolders: subfolders,
      files: folder.file_resources.map { |file| { name: file.name } }
    }
  end
end
