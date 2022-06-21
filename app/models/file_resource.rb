class FileResource < ApplicationRecord
  belongs_to :folder

  def breadcrumbs
    folder.breadcrumbs + '/' + name
  end
end
