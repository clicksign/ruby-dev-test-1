module V1
    class ArchivesController < ApplicationController
        def create
          ArchiveSaving.new(archive_params.to_h).call
        end

        private 
        def archive_params
          params.require(:archive).permit(:name, :directory, data: [])
        end
    end
end
