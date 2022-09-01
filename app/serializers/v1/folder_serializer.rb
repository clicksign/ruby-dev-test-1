module V1
  class FolderSerializer < ActiveModel::Serializer
    attributes :id, :name
    
    belongs_to :parent do 
      link(:related) { v1_folder_parent_url(object)}
    end

    has_many :sub_folders do 
      link(:related) { v1_folder_sub_folders_url(object)}
    end

    has_many :uploads do 
      link(:related) { v1_folder_uploads_url(object)}
    end
  
    link(:self) { v1_folder_url(object)}

    def attributes(*args)
      h = super(*args)    
      h
    end
  end  
end