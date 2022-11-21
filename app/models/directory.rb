class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true

  has_many :subdirectories, class_name: 'Directory', foreign_key: 'parent_id', dependent: :destroy
  has_many :uploads, class_name: 'Upload', dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :parent_id }
end
