require "test_helper"

class AppFileTest < ActiveSupport::TestCase
  test 'Arquivo não pode ser criado sem o anexo e sem pasta' do
    app_file = AppFile.new

    assert !app_file.valid?
  end

  test 'Arquivo não pode ser criado sem o anexo' do
    app_folder = AppFolder.new(folder_name: 'root')
    app_file = AppFile.new(app_folder: app_folder)

    assert !app_file.valid?
  end

  test 'Arquivo deve ser criado com anexo e com pasta' do
    app_folder = AppFolder.new(folder_name: 'root')
    app_file = AppFile.new(app_folder: app_folder)
    file_content = File.open(Rails.root.join('Gemfile'))

    app_file.file_content.attach(io: file_content, filename: File.basename(file_content))

    assert app_file.save
    assert app_file.file_content.attached?
  end

  test 'Deve retornar somente os arquivos sem pasta' do
    app_folder  = AppFolder.new(folder_name: 'pasta')

    file_1        = AppFile.new(app_folder: app_folder)
    file_content  = File.open(Rails.root.join('Gemfile'))
    file_1.file_content.attach(io: file_content, filename: File.basename(file_content))
    assert file_1.save

    file_2        = AppFile.new
    file_content  = File.open(Rails.root.join('Gemfile'))
    file_2.file_content.attach(io: file_content, filename: File.basename(file_content))
    assert file_2.save

    assert_equal AppFile.root_files, [file_2]
  end
end
