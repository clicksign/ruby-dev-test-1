module AttachmentExtended
  extend ActiveSupport::Concern

  included do
    def self.recursive_serialized_with_files
      arrange_serializable(order: :name) do |parent, children|
        {
          id: parent.id,
          name: parent.name,
          subdirectories: children,
          files: parent.files.map do |file|
            {
              filename: file.blob.filename,
              content_type: file.blob.content_type,
              byte_size: file.blob.byte_size
            }
          end
        }.reject { |k, v| v.blank? }
      end
    end
  end
end
