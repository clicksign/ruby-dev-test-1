class DocumentFile < ApplicationRecord
    belongs_to :folder
    has_one_attached :file

    validates :title, presence: { message: "Cannot be blank" }

    
    def content=(value)
        unless value.is_a?(String)
            file = File.basename(value)
            directory = "#{Rails.root}/public/files"
            file_directory =  "#{directory}/#{file}"

            Dir.mkdir(directory) unless Dir.exists?(directory)
            File.open(file_directory, "wb") { |f| f.write(value.read)}

            file_directory
        end
    end
end
