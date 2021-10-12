class Archive < ApplicationRecord
  belongs_to :sub_directory, optional: true
  attr_accessor :path # Permitir acessar o atributo path

  validates_presence_of :file # Validação para o arquivo esta presente
  before_save :check_directory # Antes de salvar o arquivo ele verifica se existe diretorio

  # Função de verificação de diretorio
  def check_directory
    if path.present?
      parse_dir = SubDirectory.get_dir(path)
      directory = SubDirectory.find_by(name: parse_dir.name) if SubDirectory.exists?(
        name: parse_dir.name, path: parse_dir.path
      )
      if directory.blank?
        parse_dir.save!
        get_file(parse_dir)
      else
        get_file(directory)
      end
    else
      get_file(path)
    end
  end

  # Função para tratamento do arquivo antes de salvar
  def get_file(dir_id)
    self.sub_directory_id = dir_id.id if dir_id.present?
    name_file = file.original_filename
    self.name = File.basename(file.original_filename, File.extname(file.original_filename))
    self.mime_type = file.content_type
    self.file = File.binread(file.tempfile.path)
  end
end
