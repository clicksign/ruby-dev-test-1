class Folder < ApplicationRecord
    # pode receber chave estrangeira de um diretório pai
    belongs_to :parent_folder, optional: true, class_name: 'Folder'

    # Da mesma forma que o diretório pai passa sua referência pros filhos.
    has_many :subfolders, 
      dependent: :destroy,
      class_name: 'Folder',
      foreign_key: 'parent_folder_id'
  
    validates :name, presence: true
    has_many_attached :files

end
