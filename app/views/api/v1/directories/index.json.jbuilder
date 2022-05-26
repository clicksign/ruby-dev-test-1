# frozen_string_literal: true

json.array! @directories, partial: 'api/v1/directories/directory', as: :directory
