class ArchivesService
  class << self
    def create_and_associate_file(archive_params)
      directory_params = { path: archive_params[:path] }
      archive_params   = {
        name: archive_params[:file].original_filename,
        file: archive_params[:file]
      }

      archive = ArchivesRepository.create(archive_params)
      associate_file(directory_params[:path], archive, archive_params[:file])
    end

    private

    def associate_file(path, archive, file_bin)
      directory         = DirectoriesRepository.find_or_create(path)
      archive.directory = directory if directory

      archive.file.attach(file_bin)
      archive.tap(&:save)
    end
  end
end
