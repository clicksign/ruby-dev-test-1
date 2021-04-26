class Api::V1::ArchivesController < ApplicationController
  before_action :set_archive, only: %i[show update destroy]

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

  def show
  end

  def update
    respond_to do |format|
      if @archive.update(archive_params)
        format.json { render 'api/v1/archives/update/success' }
      else
        format.json { render 'api/v1/archives/update/failure', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @archive.destroy!
    head :no_content
  end

  private

  def set_archive
    begin
      @archive = Archive.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Archive not found', status: 204 }
    end
  end

  def archive_params
    params.permit(:name, :directory_id, :file)
  end
end