# frozen_string_literal: true

module Api
  module V1
    class ArchivesController < ApplicationController
      before_action :archive, only: :show

      def index
        archives = Archive.page(page)
        json_pagination(archives, ArchiveSerializer)
      end

      def show
        json_response(archive, ArchiveSerializer)
      end

      def create
        archive = ArchiveInteraction::Create.run!(archive_params)
        json_response(archive, ArchiveSerializer)
      end

      private

      def archive_params
        params.permit(:directory_id, :document)
      end

      def archive
        @archive ||= Archive.find(params[:id])
      end
    end
  end
end
