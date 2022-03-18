class FoldersController < ApplicationController
  before_action :set_folder, only: %i[show edit update destroy]

  # GET /folders or /folders.json
  def index
    @folders = Folder.root_folders
    @documents = Document.root_documents
  end

  # GET /folders/1 or /folders/1.json
  def show
    @folder = Folder.find_by_id(params[:id])
    @folders = @folder.subfolders
    @documents = @folder.documents
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit; end

  # POST /folders or /folders.json
  def create
    @folder = Folder.new(folder_params)
    respond_to do |format|
      if @folder.save
        format.html { redirect_to custom_redirect_url(@folder.parent_folder), notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1 or /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to custom_redirect_url(@folder.parent_folder), notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1 or /folders/1.json
  def destroy
    parent_folder = @folder.parent_folder
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to custom_redirect_url(parent_folder), status: :see_other, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_folder_id)
  end

  def custom_redirect_url(folder = nil)
    folder.present? ? folder_url(folder) : folders_url
  end
end
