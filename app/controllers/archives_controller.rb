class ArchivesController < ApplicationController
  # Action de criação dos arquivos e diretorios ​​.
  def create
    archive = Archive.new(archive_params)
    if archive.save
      dir = archive.sub_directory_id.blank? ? '/' : archive.sub_directory.path
      render json: { id: archive.id, name_archive: archive.name, diretorio: dir }
    else
      render json: { error: { msg: archive.errors.full_messages.join } }
    end
  end

  # Action para consultar pelo id do arquivo ​​.
  def show
    archive = Archive.find(params[:id])
    if archive
      dir = archive.sub_directory_id.blank? ? '/' : archive.sub_directory.path
      render json: { id: archive.id, name_archive: archive.name, path: dir } 
    else
      render json: { error: { msg: archive.errors.full_messages, code: 404 } }
    end
  end

  # Action para consultar pelo nome o diretorio ​​.
  def show_directory
    directory = SubDirectory.find_by(name: params[:name])
    if directory
      render json: { id: directory.id, name_directory: directory.name, path: directory.path, archives: directory.archives.map{|a| a.name}} 
    else
      render json: { error: { msg: 'Empty directory', code: 404 } }
    end
  end

  private

  # Permitir apenas uma lista de parametros confiaveis ​​.
  def archive_params
    params.permit(:file, :path)
  end
end
