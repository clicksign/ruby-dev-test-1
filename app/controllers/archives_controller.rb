class ArchivesController < ApplicationController
  before_action :set_archive, only: %i[ destroy ]
  
  def create
    @archive = Archive.create(archive_params)
    load_directories
    if @archive.save
      build_archive
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    load_directories
    @archive.destroy
    build_archive

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    def set_archive
      @archive = Archive.find(params[:id])
    end

    def archive_params
      params.require(:archive).permit(:name, :file, :directory_id)
    end

    def load_directories
      @current_directory = @archive.directory
      @directories = @current_directory.child_directories
      @archives = @current_directory.archives
    end
    
    def build_archive
      @archive = Archive.new
    end
end
