class FolderSerializer
  include JSONAPI::Serializer  
  include Rails.application.routes.url_helpers

  attributes :id, :name

  has_many :uploads, links: {    
    related: -> (object) {
      v1_folder_upload_url(object)
    }
  }

  link :self, :url
end

