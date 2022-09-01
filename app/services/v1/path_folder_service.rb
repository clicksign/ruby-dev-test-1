module V1
    class PathFolderService
        def initialize(folder)
            @folder = folder        
        end

        def call
            path(@folder)
        end
    end
end