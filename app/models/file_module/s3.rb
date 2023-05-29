# frozen_string_literal: true

module FileModule
  class S3 < Storage
    has_one_attached :attachment, service: :amazon
  end
end
