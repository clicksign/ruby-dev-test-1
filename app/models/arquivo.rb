class Arquivo < ActiveRecord::Base
  has_many :arquivos, class_name: 'Arquivo', foreign_key: 'diretorio_id'
  belongs_to :diretorio_pai, class_name: 'Arquivo'
  scope :diretorios_raiz, -> { where(diretorio_id: nil) }

  def pasta?
    pasta === true
  end
end
