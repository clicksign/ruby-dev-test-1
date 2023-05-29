# frozen_string_literal: true

module FileModule
  class Blob < Storage
    validates :file_data, presence: true
  end
end
