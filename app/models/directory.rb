class Directory < ApplicationRecord
  belongs_to :parent_directory, class_name: 'Directory', optional: true
  has_many :documents, dependent: :destroy
  has_many :subdirectories, class_name: 'Directory', foreign_key: 'parent_directory_id', dependent: :destroy
  validates :name, presence: true

  def full_path
    parents = [name]
    if parent_directory.present?
      parents.unshift(*parent_directory.full_path)
    end
    parents.join('/')
  end
end
