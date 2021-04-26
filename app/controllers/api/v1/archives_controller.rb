class Api::V1::ArchivesController < ApplicationController
  def create
    respond_to do |format|
      @archive = Archive.create(archive_params)

      if @archive.save
        format.json { render 'api/v1/archives/create/success' }
      else
        format.json { render 'api/v1/archives/create/failure', status: :unprocessable_entity }
      end
    end
  end

  private

  def archive_params
    params.permit(:name, :directory_id)
  end
end