class DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[ show edit update destroy ]
  before_action :set_directory_ref, only: %i[ new create ]

  # GET /directories or /directories.json
  def index
    @directories = Directory.borders
  end

  # GET /directories/1 or /directories/1.json
  def show
  end

  # GET /directories/new
  def new
    @directory = Directory.new
  end

  # GET /directories/1/edit
  def edit
  end

  # POST /directories or /directories.json
  def create
    @directory = Directory.new(directory_params)
    
    respond_to do |format|
      if @directory.save
        format.html { redirect_to @directory, notice: "Directory was successfully created." }
        format.json { render :show, status: :created, location: @directory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directories/1 or /directories/1.json
  def update
    respond_to do |format|
      if @directory.update(directory_params.except(:ref_directory_id))
        format.html { redirect_to @directory, notice: "Directory was successfully updated." }
        format.json { render :show, status: :ok, location: @directory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1 or /directories/1.json
  def destroy
    @directory.destroy
    respond_to do |format|
      format.html { redirect_to directories_url, notice: "Directory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directory
      @directory = Directory.find(params[:id])
    end

    def set_directory_ref
      @directory_ref = Directory.find(params[:directory_id]) if params[:directory_id]
    end

    # Only allow a list of trusted parameters through.
    def directory_params
      params.require(:directory).permit(:name,:ref_directory_id)
    end
end
