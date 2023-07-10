class FileUploader < CarrierWave::Uploader::Base
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.folder.full_path}/"
  end
end
