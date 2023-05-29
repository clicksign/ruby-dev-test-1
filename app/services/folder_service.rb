# frozen_string_literal: true

class FolderService
  def initialize(params)
    @params = params
  end

  def create
    folder = Folder.find_or_initialize_by(path: @params[:path])

    if folder.new_record?    
      folders = FolderService.create_parent_folders(@params[:path])
      folder_name = File.basename(@params[:path])

      folder.name =folder_name
      folder.parent_folder = folders.last
      folder.save!
    end
    folder
  end

  def self.create_parent_folders(full_path)
    folder_name = File.basename(full_path)
    path = File.dirname(full_path)
    folders = [Folder.find_by(path: path)]

    path.split('/').each do |folder|
      folders << Folder.create(name: folder, parent_folder: folders.last)
    end unless folders.last    
    folders
  end
end
