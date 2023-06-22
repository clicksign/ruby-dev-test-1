class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :subdirectories, class_name: 'Directory', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :parent

  validates :name, presence: true

  has_many_attached :files

  def attach_file(file)
    files.attach(file)
  end
end
