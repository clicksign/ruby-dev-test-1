class FileSerializer
  include JSONAPI::Serializer

  attributes :filename, :byte_size, :content_type

  link :file_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object)
  end
end
