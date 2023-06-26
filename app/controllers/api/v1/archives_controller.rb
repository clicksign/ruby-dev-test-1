module Api::V1
  class ArchivesController < BaseController
    before_action :find_archive!, only: %i[show update destroy]

    # GET /api/v1/archives
    def index
      archives = ArchiveSearch
                      .search(Archive.all, **search_params)
                      .result

      records = paginate(archives)

      render json: each_serialize(records, ArchiveSerializer)
    end

    # GET /api/v1/archives/:id
    def show
      render json: serialize(@archive, ArchiveSerializer)
    end

    # POST /api/v1/archives
    def create
      @archive = Archive.new archive_params

      if @archive.save
        render json: serialize(@archive, ArchiveSerializer), status: :created
      else
        render json: { errors: @archive.errors },
          status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/archives/:id
    def update
      if @archive.update archive_params
        render json: serialize(@archive, ArchiveSerializer), status: :ok
      else
        render json: { errors: @archive.errors },
          status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/directories/:id
    def destroy
      if @archive.destroy
        render status: :no_content
      else
        render json: { errors: @archive.errors },
          status: :unprocessable_entity
      end
    end

    private

    def find_archive!
      @archive = Archive.find(params[:id])
    end

    def search_params
      multiple_params = [
        ArchiveSearch::ATTRIBUTES,
        ArchiveSearch::ATTRIBUTES.each_with_object({}) { |a, hash| hash[a] = [] }
      ]

      params.permit(multiple_params)
    end

    def archive_params
      filename = params[:file]&.original_filename

      params.permit(:file, :directory_id).with_defaults(name: filename)
    end
  end
end
