class FoldersController < ApplicationController
  before_action :set_folder, only: %i[show edit update destroy]

  # GET /folders or /folders.json
  def index
    @folder = Folder.root_folder
    @folders = @folder.subfolders.order(:name)
    @documents = @folder.documents.order(:filename)
  end

  # GET /folders/1 or /folders/1.json
  def show
    @folders = @folder.subfolders.order(:name)
    @documents = @folder.documents.order(:filename)
  end

  # GET /folders/new_folder
  def new_folder
    @folder = Folder.new(parent_folder_id: params[:id])
  end

  # GET /folders/1/edit
  def edit; end

  # POST /folders or /folders.json
  def create
    @folder = Folder.new(folder_params)
    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_url(@folder.parent_folder), notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new_folder, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1 or /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to folder_url(@folder.parent_folder), notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1 or /folders/1.json
  def destroy
    @folder.destroy

    respond_to do |format|
      format.html do
        redirect_to folder_url(@folder.parent_folder_id), status: :see_other,
                                                          notice: 'Folder was successfully destroyed.'
      end
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
end
