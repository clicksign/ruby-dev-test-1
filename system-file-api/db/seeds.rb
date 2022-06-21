# frozen_string_literal: true

# create folders
folder_one = FolderRecord.find_or_create_by(id: 1) do |item|
  item.name = 'Folder 1'
  item.folder_id = nil
end

FolderRecord.find_or_create_by(id: 2) do |item|
  item.name = 'Folder 2'
  item.folder_id = folder_one.id
end

FolderRecord.find_or_create_by(id: 3) do |item|
  item.name = 'Folder 3'
  item.folder_id = folder_one.id
end

FileItemRecord.find_or_create_by!(id: 1) do |item|
  item.folder_id = folder_one.id
  item.name = 'postgres.png'
  item.content.attach(io: File.open('./db/files/postgres.png'), filename: 'postgres.png')
end
