# frozen_string_literal: true

module FileModule
  class Local < Storage
    has_one_attached :attachment, service: :local
  end
end
