class Arquivo < ActiveRecord::Base
  has_one_attached :conteudo

  has_many :arquivos, class_name: 'Arquivo', foreign_key: 'diretorio_id', dependent: :destroy
  belongs_to :diretorio, class_name: 'Arquivo', optional: true
  scope :diretorios_raiz, -> { where(diretorio_id: nil) }
  scope :diretorios_irmaos, -> (diretorio_id) { where(diretorio_id: diretorio_id) }

  validates :nome, presence: true, allow_blank: false
  validate :conteudo_obrigatorio, :conteudo_nao_obriigatorio, :diretorio_invalido, :arquivo_ja_existe

  def pasta?
    pasta === true
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
      errors.add(:diretorio, "O diretório informado não é uma pasta")
    end
    if !diretorio_id.nil? && diretorio_id == id
      errors.add(:diretorio, "O arquivo não ter ele mesmo como diretorio")
    end
  end

  def arquivo_ja_existe
    possui_arquivo_irmao_igual = Arquivo.diretorios_irmaos(diretorio_id)
                                        .where("lower(nome) = lower(:nome)", nome: nome)
                                        .where(":id is null or id != :id", id: id)
                                        .count > 0
    if possui_arquivo_irmao_igual
      errors.add(:nome, "O diretório informado já comtém um arquivo com esse nome")
    end
  end
end
