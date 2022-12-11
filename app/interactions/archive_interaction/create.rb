# frozen_string_literal: true

module ArchiveInteraction
  class Create < BaseInteraction
    file :document
    string :directory_id

    def execute
      create_archive
    end

    private

    def create_archive
      within_transaction do
        Archive.create!(directory_id:, document: file_blob)
      end
    end

    def file_blob
      ActiveStorage::Blob.create_and_upload!(
        io: document,
        filename: File.basename(document.path, '.*'),
        content_type: File.extname(document.path)
      )
    end
  end
end
