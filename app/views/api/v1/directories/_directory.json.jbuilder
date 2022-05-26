# frozen_string_literal: true

json.extract! directory, :id, :name, :parent_id, :created_at, :updated_at
json.files do
  directory.files.each do |f|
    json.file f.blob
  end
end
