# frozen_string_literal: true

module DirectoryInteraction
  class Create < BaseInteraction
    string :dirname
    string :directory_id, default: nil

    validate :directory_not_found, if: -> { directory_id_valid? && directory.blank? }
    validate :dirname_missing, if: -> { dirname.blank? }
    validate :directory_id_invalid, if: -> { directory_id.present? }

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

    def directory_id_invalid
      return if directory_id_valid?

      errors.add(
        :base,
        :invalid_type,
        field: I18n.t('active_interaction.field.parent_id')
      )
    end

    def directory_not_found
      raise ActiveInteraction::InvalidInteractionError,
            I18n.t('active_interaction.errors.messages.directory_not_found')
    end

    def directory_id_valid?
      UUIDV4.match?(directory_id)
    end

    def directory
      @directory ||= Directory.find(directory_id)
    end
  end
end
