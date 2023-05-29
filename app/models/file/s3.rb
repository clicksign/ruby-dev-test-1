# frozen_string_literal: true

class File::S3 < Storage
  has_one_attached :attachment, service: :amazon
end
