# frozen_string_literal: true

module Shared
  module FolderValidation
    def folder_parent_valid?(input)
      !input.folder_id.nil? && !FolderRepository.exists(input.folder_id)
    end
  end
end
