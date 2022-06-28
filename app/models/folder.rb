class Folder < ApplicationRecord
  has_ancestry
  belongs_to :parent, class_name: 'Folder', optional: true, foreign_key: :folder_id

  has_many :archives, inverse_of: :folder, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { scope: :parent }
end
