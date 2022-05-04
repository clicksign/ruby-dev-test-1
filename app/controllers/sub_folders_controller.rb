class SubFoldersController < ApplicationController
  before_action :set_sub_folder, only: %i[ show edit update destroy ]

  include SubFolderConcern

  # GET /sub_folders or /sub_folders.json
  def index
    @sub_folders = SubFolder.all
  end

  # GET /sub_folders/1 or /sub_folders/1.json
  def show
  end

  # GET /sub_folders/new
  def new
    @sub_folder = SubFolder.new
  end

  # GET /sub_folders/1/edit
  def edit
  end

  # POST /sub_folders or /sub_folders.json
  def create
    @sub_folder = SubFolder.new(sub_folder_params)

    respond_to do |format|
      if @sub_folder.save
        if there_is_a_folder?(sub_folder_params)
          @folder = create_sub_folder_into_a_folder(sub_folder_params)

          format.html { redirect_to folder_url(@folder), notice: "Sub folder was successfully created." }
          format.json { render :show, status: :created, location: @folder }
        else
          format.html { redirect_to sub_folder_url(@sub_folder), notice: "Sub folder was successfully created." }
          format.json { render :show, status: :created, location: @sub_folder }
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sub_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_folders/1 or /sub_folders/1.json
  def update
    respond_to do |format|
      if @sub_folder.update(sub_folder_params)
        format.html { redirect_to sub_folder_url(@sub_folder), notice: "Sub folder was successfully updated." }
        format.json { render :show, status: :ok, location: @sub_folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sub_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_folders/1 or /sub_folders/1.json
  def destroy
    @sub_folder.destroy

    respond_to do |format|
      format.html { redirect_to sub_folders_url, notice: "Sub folder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_folder
      @sub_folder = SubFolder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sub_folder_params
      params.require(:sub_folder).permit(:name, :folder_id_form_url)
    end
end
