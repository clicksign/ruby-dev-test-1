# frozen_string_literal: true

class File::Blob < Storage
  validates :file_data, presence: true
end