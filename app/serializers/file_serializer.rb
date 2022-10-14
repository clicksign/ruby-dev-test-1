class FileSerializer < ActiveModel::Serializer
  attributes :id, :filename, :byte_size, :byte_size_readable, :url, :created_at

  def url
    Rails.application.routes.url_helpers.rails_blob_path(object, only_path: true)
  end

  def filename
    object.blob.filename
  end

  def byte_size
    object.blob.byte_size
  end

  def byte_size_readable
    ActionController::Base.helpers.number_to_human_size(byte_size)
  end
end
