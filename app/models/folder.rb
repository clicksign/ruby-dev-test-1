class Folder < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :delete_all 
  has_many :children, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Folder', optional: true

  validates :name, presence: true

  def self.network_parents(folder)
    parents = [folder]
    while !folder.parent.nil?
      folder = folder.parent
      parents.push(folder)
    end
    parents.reverse
  end
end
