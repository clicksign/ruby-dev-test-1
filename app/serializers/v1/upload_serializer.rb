module V1
  class UploadSerializer < ActiveModel::Serializer
    attributes :id, :file
  
    belongs_to :folder do 
      link(:related) { v1_folder_url(object.folder)}
    end
  
    link(:self) { v1_folder_upload_url(object.folder, object)}

    def attributes(*args)
      h = super(*args)  
      h[:url] = object.file.url
      h
    end
  end
end