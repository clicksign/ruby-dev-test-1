class ArchiveSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :directory_id,
             :path,
             :url

  def path
    object&.path
  end

  def url
    object&.url
  end
end
