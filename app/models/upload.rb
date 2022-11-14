class Upload < ApplicationRecord
  include ActiveModel::Validations

  has_many_attached :file
  validates :title, presence: true
  before_save :attach_file

  # validates_with UploadListValidation

  def attach_file
    self.file.attach(
      io: StringIO.new(self.info['file']),
      filename: 'placeholder_image.png',
      content_type: self.info['content_type']
    )
  end

end
