class Arquivo < ActiveRecord::Base
  has_one_attached :conteudo

  has_many :arquivos, class_name: 'Arquivo', foreign_key: 'diretorio_id'
  belongs_to :diretorio, class_name: 'Arquivo', optional: true
  scope :diretorios_raiz, -> { where(diretorio_id: nil) }

  def pasta?
    pasta === true
  end

  def full_caminho
    "#{caminho}/#{nome}"
  end
end
