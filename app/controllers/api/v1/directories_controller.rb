module Api::V1
  class DirectoriesController < BaseController
    before_action :find_directory!, only: %i[show update destroy]

    # GET /api/v1/directories
    def index
      directories = DirectorySearch
                      .search(Directory.all, **search_params)
                      .result

      records = paginate(directories)

      render json: each_serialize(records, DirectorySerializer)
    end

    # GET /api/v1/directories/:id
    def show
      render json: serialize(@directory, DirectoryShowSerializer)
    end

    # POST /api/v1/directories
    def create
      @directory = Directory.new directory_params

      if @directory.save
        render json: serialize(@directory, DirectorySerializer), status: :created
      else
        render json: { errors: @directory.errors },
          status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/directories/:id
    def update
      if @directory.update directory_params
        render json: serialize(@directory, DirectorySerializer), status: :ok
      else
        render json: { errors: @directory.errors },
          status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/directories/:id
    def destroy
      if @directory.destroy
        render status: :no_content
      else
        render json: { errors: @directory.errors },
          status: :unprocessable_entity
      end
    end

    private

    def find_directory!
      @directory = Directory.find(params[:id])
    end

    def search_params
      multiple_params = [
        DirectorySearch::ATTRIBUTES,
        DirectorySearch::ATTRIBUTES.each_with_object({}) { |a, hash| hash[a] = [] }
      ]

      params.permit(multiple_params)
    end

    def directory_params
      params.permit(:name, :parent_id)
    end
  end
end
