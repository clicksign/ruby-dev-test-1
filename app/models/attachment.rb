class Attachment < ApplicationRecord
  has_one_attached :file

  def file_url
    if file.attached?
      file.blob.service_url
    end
  end

end
