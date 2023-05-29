# frozen_string_literal: true

json.array! @files, partial: 'api/files/file', as: :file
