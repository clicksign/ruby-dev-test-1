class AttachFilesController < ApplicationController
  before_action :set_attach_file, only: %i[ show update destroy ]

  # GET /attach_files
  # GET /attach_files.json
  def index
    @attach_files = AttachFile.all
  end

  # GET /attach_files/1
  # GET /attach_files/1.json
  def show
  end

  # POST /attach_files
  # POST /attach_files.json
  def create
    @attach_file = AttachFile.new(attach_file_params)

    if @attach_file.save
      render :show, status: :created, location: @attach_file
    else
      render json: @attach_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attach_files/1
  # PATCH/PUT /attach_files/1.json
  def update
    if @attach_file.update(attach_file_params)
      render :show, status: :ok, location: @attach_file
    else
      render json: @attach_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attach_files/1
  # DELETE /attach_files/1.json
  def destroy
    @attach_file.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attach_file
      @attach_file = AttachFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attach_file_params
      params.require(:attach_file).permit(:name, :folder_id)
    end
end
