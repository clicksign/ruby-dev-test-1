require "test_helper"

class AppFilesControllerTest < ActionDispatch::IntegrationTest
  test "should post create" do
    file_path = "#{Rails.root}/test/fixtures/files/test_file.txt"
    composer_file = fixture_file_upload(file_path,'text/plain')

    post app_files_url, params: { app_file: { file_content: composer_file }}
    assert_redirected_to(root_path)
    assert_equal(File.basename(file_path), AppFile.last.file_content.filename.to_s)
  end

  test "should delete destroy" do
    file_path = "#{Rails.root}/test/fixtures/files/test_file.txt"
    file      = File.open(file_path)
    app_file  = AppFile.new
    app_file.file_content.attach(io: file, filename: File.basename(file_path))
    
    assert(app_file.save)

    delete app_file_url(app_file)
    assert_redirected_to(root_path)
    assert_not(AppFile.exists?(app_file.id))
  end
end
