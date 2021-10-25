class ArchivesController < ApplicationController
  def create
    @archive = ArchivesService.create_and_associate_file(archive_params)

    render status: :created if @archive.save
  end

  private

  def archive_params
    params.permit(:path, :file)
  end
end
