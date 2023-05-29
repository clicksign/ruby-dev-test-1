# frozen_string_literal: true

json.array! @folders, partial: 'api/folders/folder', as: :folder
