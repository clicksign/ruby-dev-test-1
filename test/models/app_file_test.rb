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
end
