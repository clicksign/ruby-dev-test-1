module V1
  class CreateFolderService
    def initialize(*args)
      @folder = args[0]        
    end

    def call
      folder = Folder.create(@folder)
    end
  end
end