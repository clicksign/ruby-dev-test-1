Rails.configuration.to_prepare do
  # Create an active storage extension module to add to 
  # the ActiveStorage::Attachment model the rename method
  module ActiveStorageAttachmentExtension 
    extend ActiveSupport::Concern

    def rename(file_name)
      self.blob.update(filename: file_name)
    end

    def move(folder)
      self.update(record_id: folder.id)
    end
  end

  # Include the extension module in the ActiveStorage::Attachment model
  ActiveStorage::Attachment.include ActiveStorageAttachmentExtension
end
