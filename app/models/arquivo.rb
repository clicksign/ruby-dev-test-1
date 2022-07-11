class Arquivo < ActiveRecord::Base
  has_one_attached :conteudo

  has_many :arquivos, class_name: 'Arquivo', foreign_key: 'diretorio_id'
  belongs_to :diretorio, class_name: 'Arquivo', optional: true
  scope :diretorios_raiz, -> { where(diretorio_id: nil) }

  validate :conteudo_obrigatorio, :conteudo_nao_obriigatorio, :diretorio_invalido

  def pasta?
    pasta === true
  end

  def caminho_completo
    caminho == '/' ? "/#{nome}" : "#{caminho}/#{nome}"
  end

  private

  def conteudo_obrigatorio
    if conteudo.blank? && !pasta?
      errors.add(:conteudo, "O conteúdo do arquivo é obrigatório")
    end
  end

  def conteudo_nao_obriigatorio
    if !conteudo.blank? && pasta?
      errors.add(:conteudo, "Pasta não pode ter conteúdo")
    end
  end

  def diretorio_invalido
    if !diretorio.nil? && !diretorio.pasta?
      errors.add(:conteudo, "O diretório informado não é uma pasta")
    end
  end
end
