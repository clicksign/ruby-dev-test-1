require 'faker'

file_to_upload = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/attachments/image.png", 'image/png')

FactoryBot.define do
  factory :arquivo_valido, class: Arquivo do
    nome { Faker::File.file_name }
    pasta { false }
    conteudo { file_to_upload }
  end
  factory :arquivo_sem_conteudo, class: Arquivo do
    nome { Faker::File.file_name }
    pasta { false }
  end
  factory :arquivo_sem_nome, class: Arquivo do
    pasta { false }
    conteudo { file_to_upload }
  end
  factory :arquivo_com_diretorio_valido, class: Arquivo do
    nome { Faker::File.file_name }
    diretorio { :pasta_valida }
    pasta { false }
  end
  factory :arquivo_com_diretorio_invalido, class: Arquivo do
    nome { Faker::File.file_name }
    pasta { false }
  end
  factory :pasta_valida, class: Arquivo do
    nome { Faker::File.dir(segment_count: 1) }
    pasta { true }
  end
  factory :pasta_com_conteudo, class: Arquivo do
    nome { Faker::File.dir(segment_count: 1) }
    pasta { true }
    conteudo { file_to_upload }
  end
end
