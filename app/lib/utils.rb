# frozen_string_literal: true

module Utils
  def self.file_name(file)
    case file.class.to_s
    when 'ActionDispatch::Http::UploadedFile'
      file.original_filename
    when 'File'
      File.basename(file)
    when 'Pathname'
      file.basename.to_s
    else
      'generic_file'
    end
  end
end
