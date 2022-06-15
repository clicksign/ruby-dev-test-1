class Directory < ApplicationRecord
  has_many :archives
  has_many :child_binds, class_name: "Bind", foreign_key: "child_id", dependent: :destroy
  has_many :children, through: :child_binds, source: :child
  
  has_one :parent_bind, class_name: "Bind", foreign_key: "parent_id", dependent: :destroy
  has_one :parent, through: :parent_bind
  
  validates :name, presence: true

  # scope :last_parent, -> (parent) { where(name: parent).last }

  def path 
    path = []
    child = self
    
    while !child.parent.nil?
      parent = child.parent
      path << parent.name
      child = parent
    end
    path
  end

  def get_archives
    archives
  end

end
