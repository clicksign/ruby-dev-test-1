class FileUploader < CarrierWave::Uploader::Base
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.folder.full_path}/"
  end

  # Example
  # def extension_white_list
  #   %w(pdf txt jpeg jpg png doc docx xls xlsx)
  # end
end
