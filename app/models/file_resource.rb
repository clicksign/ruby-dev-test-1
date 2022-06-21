class FileResource < ApplicationRecord
  belongs_to :folder
  validates :name, presence: true

  def breadcrumbs
    folder.breadcrumbs + '/' + name
  end
end
