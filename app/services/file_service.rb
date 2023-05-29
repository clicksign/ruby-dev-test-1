# frozen_string_literal: true

class FileService
  FILE_TYPES = {
    local: FileModule::Local,
    s3: FileModule::S3,
    blob: FileModule::Blob
  }.freeze

  def initialize(params)
    @params = params
    @file_name = File.basename(@params[:path].to_s)
    @dir_name = File.dirname(@params[:path].to_s)
  end

  def create
    folder = FolderService.new({ path: @dir_name }).create

    base64 = Base64.strict_decode64(@params[:data])

    file_params = { name: @file_name, folder: folder }

    if @params[:type] == 'blob'
      file_params[:file_data] = StringIO.open(base64)
    else
      file_params[:attachment] = { io: StringIO.open(base64), filename: @file_name }
    end

    file = FILE_TYPES[@params[:type].to_sym].new(file_params)

    file.save!
    file
  end

  def list_by_name
    Storage.where(name: @params[:name])
  end
end
