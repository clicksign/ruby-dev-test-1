class UploadSerializer
    include JSONAPI::Serializer  
    include Rails.application.routes.url_helpers
  
    attributes :id, :file
  
    belongs_to :uploads, links: {    
      related: -> (object) {
        v1_folder_path_url(object)
      }
    }
  
    link :self, :url
  end
  
  