# frozen_string_literal: true

class FileService
  FILE_TYPES = {
    local: File::Local,
    s3: File::S3,
    blob: File::Blob
  }

  def initialize(params)
    @params = params
  end

  def create
    file_name = File.basename(@params[:path])
    dir_name = File.dirname(@params[:path])
    folder = FolderService.new({path: dir_name}).create

    base_64 = Base64.strict_decode64(@params[:data])

    file_params = {
      name: file_name,
      folder: folder
    }

    if @params[:type] == 'blob'
      file_params[:file_data] = StringIO.open(base_64)
    else
      file_params[:attachment] = { io: StringIO.open(base_64), filename: file_name }
    end

    file = FILE_TYPES[@params[:type].to_sym].new(file_params)

    file.save!
    file
  end

  def list_by_name
    Storage.where(name: @params[:name])
  end
end