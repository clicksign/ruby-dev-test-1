class ArchivesUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file 
  # storage :fog
   
  def store_dir
    "uploads/archives/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf txt jpeg jpg png doc docx xls xlsx)
  end

   def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
