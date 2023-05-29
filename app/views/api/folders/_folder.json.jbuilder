# frozen_string_literal: true

json.call(folder, :id, :name, :path)

json.files folder.files, partial: 'api/files/file', as: :file

json.sub_folders folder.sub_folders, partial: 'api/folders/folder', as: :folder
