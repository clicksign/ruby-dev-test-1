class Folder < ApplicationRecord
  belongs_to :parent, :class_name => 'Folder', optional: true
  has_many :subfolders, :class_name => 'Folder', foreign_key: 'parent_id', dependent: :destroy
  has_many :files, dependent: :destroy

  scope :roots, -> { where(parent_id: nil) }


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
