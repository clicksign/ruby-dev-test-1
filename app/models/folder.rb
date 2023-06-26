class Folder < ApplicationRecord
  has_ancestry

  # associations

  belongs_to :file_system
  has_many :documents

  # validations

  validates :name, presence: true

  # methods

  def pathname
    path.pluck(:name).join(" / ")
  end
end
