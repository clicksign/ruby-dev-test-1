# frozen_string_literal: true

module Api
  module V1
    class DirectoriesController < ApplicationController
      before_action :page, only: %i[index show]
      before_action :directory, only: %i[show]

      def index
        directories = Directory.page(page)
        json_pagination(directories, DirectorySerializer)
      end

      def show
        json_response(directory, DirectorySerializer)
      end

      def create
        directory = DirectoryInteraction::Create.run!(directory_params)
        json_response(directory, DirectorySerializer)
      end

      private

      def directory
        @directory ||= Directory.find(params[:id])
      end

      def directory_params
        params.permit(:dirname, :directory_id)
      end
    end
  end
end
