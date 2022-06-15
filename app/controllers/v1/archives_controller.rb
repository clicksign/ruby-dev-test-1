module V1
    class ArchivesController < ApplicationController
        def create
          saving_service = ArchiveSaving.new(archive_params.to_h)
          saving_service.call
          @archives = saving_service.archive
          render json: @archive
        end

        private 
        def archive_params
          params.require(:archive).permit(:name, :directory, data: [])
        end
    end
end
