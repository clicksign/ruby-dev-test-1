# frozen_string_literal: true

module Documentable
  extend ActiveSupport::Concern

  included do
    belongs_to :directory
    has_one_attached :document
    validates :document, presence: true

    def size
      document.byte_size
    end

    def name
      document.filename.to_s
    end
  end
end
