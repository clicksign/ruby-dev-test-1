class Document < ApplicationRecord
  has_one_attached :file
  belongs_to :directory

  validates_associated :directory
  validates :file, attached: true, content_type: :pdf
  validates_presence_of :name, :ext, :size, :path
end
