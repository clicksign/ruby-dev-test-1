class Upload < ApplicationRecord
  include ActiveModel::Validations

  has_many_attached :files
  validates :title, presence: true
  after_save :attach_file

  belongs_to :directory, class_name: 'Directory'

  def attach_file
    attachment_files = []
    self.info['files'].map do |file|
      attachment_files << {
        key: "upload/#{self.id}/#{self.info['path']}/#{SecureRandom.uuid}",
        io: StringIO.new(file['io']),
        filename: file['filename'],
        content_type: file['content_type']
      }
    end

    self.files.attach(attachment_files)
  end

end
