module V1
  class DirectoriesController < ApplicationController

    def index 
      @directories = Directory.includes(:parent_bind, :archives, :children).all

      render json: @directories, methods: [:path, :get_archives]
    end

    def create
      DirectorySaving.new(directory_params).call
    end

    private

    def directory_params
      return {} unless params.has_key?(:directory)
      permited_params = params.require(:directory).permit(:name, :parent)
    end
   
  end
end