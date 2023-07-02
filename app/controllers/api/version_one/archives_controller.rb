module Api
  module VersionOne
    class ArchivesController < ApplicationController

      ATTR_METHODS = %i[id name directory_id created_by_id file]

      before_action :authenticate_user!
      before_action :set_archive, only: %i[show update destroy]

      def index
        render json: { archives: archives_filter.paginate(params[:page], 
                       only: ATTR_METHODS) }
      end

      def create
        save_attachment
        render json: { error: false, archive: @archive}
      rescue => e
        render json: { error: true, message: e }
      end

      def show
        render json: { archive: @archive }
      rescue => e
        render json: { error: true, message: e }
      end

      def update
        @archive.update(archives_params)
        render json: { archive: @archive }
      rescue => e
        render json: { error: true, message: e }
      end

      def destroy
        @archive.destroy
        render json: { error: false }
      rescue => e
        render json: { error: true, message: e }
      end

      private

      def archives_filter
        Archive.all.order(created_at: :desc)
      end

      def set_archive
        @archive = Archive.find_by(id: params[:id])
      end

      def archives_params
        params.require(:archive).permit(
          :name,
          :directory_id,
          :attachment_data => []
        )
      end

      def save_attachment
        path        = 'public/files/file.pdf'
        file        = File.open("#{Rails.root.join(path)}").read
        name        = File.basename(path)
        base64_file = Base64.encode64(file)

        @archive = Archive.create(
          name: archives_params[:name],
          file: decode64(base64_file, name),
          created_by_id: current_user.id,
          directory_id: archives_params[:directory_id],
          filename: normalize_name(path)  
        )

        @archive.update!(url: document_path(@archive.id, normalize_name(path)))
        @archive
      end

      def decode64(base64_file, name)
        tempfile = Tempfile.new(name)
        tempfile.binmode
        tempfile.write Base64.decode64(base64_file)
        tempfile.rewind

        content_type = "file --mime -b #{tempfile.path}".split(";")[0]

        ActionDispatch::Http::UploadedFile.new({
          tempfile: tempfile,
          content_type: content_type,
          filename: name
        })
      end

      def normalize_name(file)
        extension = File.extname(file)
        normalize = "#{DateTime.now}_#{File.basename(file, '.*')}".parameterize.dasherize
        "#{normalize}#{extension}"
      end

      def default_path
        # "https://#{CarrierWave::Uploader::Base.fog_directory}.s3.amazonaws.com/uploads"
        "https://clicksign_devtest1.s3.amazonaws.com/uploads/directories/archives/#{directory.name.parameterize}"
      end

      def document_path(id, name)
        "#{default_path}/#{name}"
      end

      def directory
        @directory ||= Directory.find_by(id: @archive.directory_id)
      end
    end
  end
end