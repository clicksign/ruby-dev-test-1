# frozen_string_literal: true

class DiskService
  class << self
    def get_file(path)
      Rails.root.join(path)
    end

    def create_file!(file)
      file_data = extract_data(file)

      created_file = File.open("storage/#{SecureRandom.hex(10)}_#{file_name(file)}", 'wx+') do |f|
        f.write(file_data)
        f
      end

      Pathname.new(created_file.path)
    end

    private

    def file_name(file)
      Utils.file_name(file)
    end

    def extract_data(file)
      return file if file.is_a?(String)

      file.read
    end
  end
end
