class DocumentsController < ApplicationController
  before_action :set_document, only: %i[edit update destroy]

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit; end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to custom_redirect_url(@document.folder), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to custom_redirect_url(@document.folder), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    folder = @document.folder
    @document.destroy

    respond_to do |format|
      format.html { redirect_to custom_redirect_url(folder), status: :see_other, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :folder_id, :origin)
  end

  def custom_redirect_url(folder = nil)
    folder.present? ? folder_url(folder) : folders_url
  end
end
