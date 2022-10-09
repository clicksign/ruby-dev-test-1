# frozen_string_literal: true

class DiskService
  class << self
    def get_file(path)
      Rails.root.join(path)
    end

    def create_file!(file)
      File.open("storage/#{SecureRandom.hex(10)}_#{file_name(file)}", 'w') do |f|
        f.write(file)
        f
      end
    end

    private

    def file_name(file)
      Utils.file_name(file)
    end
  end
end
