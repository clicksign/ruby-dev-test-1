# frozen_string_literal: true

class File::Local < Storage
  has_one_attached :attachment, service: :local
end