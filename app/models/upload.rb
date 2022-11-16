class Upload < ApplicationRecord
  include ActiveModel::Validations

  has_many_attached :file
  validates :title, presence: true
  after_save :attach_file

  def attach_file
    self.info['files'].map do |file|
      self.file.attach(key: self.info['path'], io: StringIO.new(file['io']), filename: file['filename'], content_type: file['content_type'])
    end
  end

end
