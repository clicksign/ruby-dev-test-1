# frozen_string_literal: true

module DirectoryInteraction
  class Create < BaseInteraction
    string :dirname
    string :directory_id, default: nil

    validate :dirname_missing, unless: -> { dirname.present? }
    validate :parent_missing, if: -> { directory_id.present? }

    def execute
      create_directory
    end

    private

    def create_directory
      within_transaction do
        Directory.create!(dirname:, parent_id: directory_id)
      end
    end

    def dirname_missing
      errors.add(:dirname, :missing)
    end

    def parent_missing
      errors.add(:directory_id, :invalid) unless parent_id_invalid?
    end

    def parent_id_invalid?
      UUIDV4.match?(directory_id)
    end
  end
end
